module OdaniaCore
	class Erb
		attr_accessor :variables, :config, :partial, :asset, :logger, :data

		def initialize(template, subdomain_config, domain_query, data={}, extra_partials={})
			self.logger = Rails.logger
			self.data = data
			@template = template.html_safe

			self.variables = Variables.new(template, subdomain_config, data, extra_partials)
			self.config = Config.new self.variables
			self.partial = Partial.new self.variables, domain_query
			self.asset = Asset.new self.variables

			if LOCAL_TEST_MODE
				data = "\n<!-- Full Domain: #{subdomain_config['full_domain']} -->"
				data += "\n<!-- Layout: #{subdomain_config['layout']} -->"

				@template += data.html_safe
			end
		end

		def render
			ERB.new(@template).result(binding)
		end

		class Variables
			attr_accessor :template, :config, :subdomain_config, :domain, :data
			attr_accessor :layout, :full_domain, :subdomain, :extra_partials

			def initialize(template, subdomain_config, data, extra_partials)
				self.template = template
				self.subdomain_config = subdomain_config
				self.extra_partials = extra_partials
				self.data = data

				self.domain = subdomain_config['domain']
				self.layout = subdomain_config['layout']
				self.full_domain = subdomain_config['full_domain']
				self.subdomain = subdomain_config['subdomain']
			end

			def get_partial(partial)
				subdomain_config['partials'][partial]
			end

			def get_config_key(key)
				subdomain_config['config'][key]
			end

			def notify_error_async(type, key, data)
				data = {
					domain: self.domain,
					subdomain: self.subdomain,
					layout: self.layout,
					full_domain: self.full_domain,
					type: type,
					key: key,
					data: data
				}
				ProcessErrorJob.perform_later JSON.dump(data)
			end
		end

		class Config
			def initialize(variables)
				@variables = variables
			end

			def get(key)
				val = @variables.get_config_key(key)
				return val unless val.nil?

				@variables.notify_error_async :config, 'Key not found', key
				"--- Config Key Not found: #{key} ---"
			end
		end

		class Partial
			def initialize(variables, domain_query)
				@variables = variables
				@domain_query = domain_query
			end

			# Let varnish fetch the partial
			def get(partial_name)
				esi_remove = '<esi:remove><p>An error occurred! ESI was not parsed!</p></esi:remove>'

				if @variables.extra_partials[partial_name].nil?
					esi_url = "http://internal.core/template/partial?partial_name=#{partial_name}&req_host=#{@variables.full_domain}"
				else
					esi_url = @variables.extra_partials[partial_name]
				end
				"<!-- Page: #{partial_name} -->\n<esi:include src=\"#{esi_url}\"/>\n#{esi_remove}\n<!-- End Page: #{partial_name} -->"
			end

			# Directly embed the partial into the page
			def embed(partial_name)
				query = {
					filtered: {
						filter: {
							bool: {
								must: [
									{term: {partial_name: partial_name}}
								]
							}
						},
						query: @domain_query
					}
				}
				result = $elasticsearch.search index: $partial_index, type: 'partial', body: query
				entries = result['hits']
				total_hits = entries['total']

				return "ERROR PARTIAL NOT FOUND #{partial_name}" if total_hits.eql? 0

				el_partial_data = get_partial_template @variables.subdomain_config['partials'][partial_name]
				return '' if el_partial_data.nil?
				odania_template = OdaniaCore::Erb.new(el_partial_data['template'], @variables.subdomain_config, @domain_query, @variables.data, @variables.extra_partials)
				odania_template.render.html_safe
			end
		end

		class Asset
			def initialize(variables)
				@variables = variables
			end

			def get(asset)
				asset_url = get_asset_url(@variables.full_domain)
				asset_url = "//#{asset_url}" unless asset_url.include? '//'
				"#{asset_url}/#{asset}"
			end

			private

			def get_asset_url(full_domain)
				return @variables.subdomain_config['asset_url'] unless @variables.subdomain_config['asset_url'].nil?
				full_domain
			end
		end
	end
end
