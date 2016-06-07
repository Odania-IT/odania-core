module OdaniaCore
	class Erb
		attr_accessor :variables, :config, :partial, :asset, :logger, :data

		def initialize(template, subdomain_config, data={}, extra_partials={})
			self.logger = Rails.logger
			self.data = data
			@template = template.html_safe

			self.variables = Variables.new(template, subdomain_config, extra_partials)
			self.config = Config.new self.variables
			self.partial = Partial.new self.variables
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
			attr_accessor :template, :config, :subdomain_config, :domain
			attr_accessor :layout, :full_domain, :subdomain, :extra_partials

			def initialize(template, subdomain_config, extra_partials)
				self.template = template
				self.subdomain_config = subdomain_config
				self.extra_partials = extra_partials

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
			def initialize(variables)
				@variables = variables
			end

			def get(partial_name, through_esi=true)
				if through_esi
					esi_remove = '<esi:remove><p>An error occurred! ESI was not parsed!</p></esi:remove>'

					if @variables.extra_partials[partial_name].nil?
						esi_url = "http://internal.core/template/partial?partial_name=#{partial_name}&req_host=#{@variables.full_domain}"
					else
						esi_url = @variables.extra_partials[partial_name]
					end
					"<!-- Page: #{partial_name} -->\n<esi:include src=\"#{esi_url}\"/>\n#{esi_remove}\n<!-- End Page: #{partial_name} -->"
				else
					# TODO Directly fetch and process template
				end
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
