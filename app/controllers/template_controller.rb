require 'odania'

class TemplateController < ApplicationController
	include EntryConcern

	# Only rendering template might result in 200 instead of 404. Is there a way to let varnish send a 404 if one page fails?
	def page
		req_host = params[:req_host]
		req_url = params[:req_url]
		subdomain_config = Odania.plugin.get_subdomain_config(req_host)

		if subdomain_config.nil?
			domain_info = PublicSuffix.parse(req_host)
			domain = domain_info.domain
			valid_domain_config = Odania.plugin.get_valid_domain_config

			# Is this a valid domain?
			valid_domains = valid_domain_config['valid_domains']
			if valid_domains[domain].nil?
				# Redirect to default domain
				valid_domains = valid_domain_config['default_domains'].empty? ? valid_domain_config['valid_domains'] : valid_domain_config['default_domains']
				domain = valid_domains.keys.first
				return render plain: 'No valid domain defined!', status: :service_unavailable if domain.nil?
				subdomain = valid_domains[domain].first
				return redirect_to "http://#{subdomain}.#{domain}"
			else
				# Redirect to valid subdomain
				default_domains = valid_domain_config['default_domains']
				subdomain = default_domains[domain].nil? ? nil : default_domains[domain].first
				subdomain = valid_domains[domain].first if subdomain.nil?
				return redirect_to "http://#{subdomain}.#{domain}"
			end
		end

		# Identify layout
		domain = subdomain_config['domain']
		selected_layout = subdomain_config['layout']
		style = '_general'
		partial_name = subdomain_config['styles'][style]['entry_point']
		logger.info "Selected Layout: '#{selected_layout}' [#{partial_name}]"

		result = $elasticsearch.search index: select_index('partial'), type: 'partial', body: {
			sort: {
				_score: 'desc'
			},
			query: {
				filtered: {
					filter: {
						bool: {
							must: [
								{term: {partial_name: partial_name}}
							]
						}
					},
					query: {
						bool: {
							should: [
								{match: {full_domain: {query: req_host, boost: 10}}},
								{match: {full_domain: {query: domain, boost: 6}}},
								{match: {domain: '_general'}}
							]
						}
					}
				}
			}
		}

		total_hits = result['hits']['total']
		logger.info "Layout total hits: #{total_hits}"

		if total_hits.eql? 0
			@error_msg = 'Sorry.... there was an internal error and we could not find the required template!'
			return error
		end

		hits = result['hits']['hits']
		hit = hits.first
		source = hit['_source']
		logger.info "Layout Best Hit: [#{hit['_score']}] #{source['full_domain']} #{source['full_path']}"
		template = source['content']

		extra_partials = {
			'content' => "http://internal.core/template/content?req_url=#{req_url}&req_host=#{req_host}"
		}

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, subdomain_config, build_domain_query(domain, req_host), {}, extra_partials)
		render html: odania_template.render.html_safe
	end

	def content
		req_host = params[:req_host]
		req_url = params[:req_url]
		subdomain_config = Odania.plugin.get_subdomain_config(req_host)

		result = render_direct_page 'web', req_host, req_url, subdomain_config
		return render html: result if result

		# Try list view
		logger.debug "No direct page found for #{req_url} [#{req_host}]"
		return error unless subdomain_config['config']['render_list_view']
		@domain = subdomain_config['domain']

		# Do we have pages belonging under this path?
		query = {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: build_filtered_domain_query(@domain, req_host, {
				bool: {
					must: [
						{prefix: {path: req_url}},
						{term: {released: true}},
						{term: {view_in_list: true}}
					]
				}
			})
		}
		result = search 'web', query
		@total_hits = result['total']
		@hits = result['hits']

		return error if @total_hits.eql? 0

		# Get list view template from layout
		partial_name = get_partial_template subdomain_config['partials']['list_view']
		result = render_direct_page 'partial', req_host, partial_name, subdomain_config, {hits: @hits, total_hits: @total_hits}
		logger.info "rendering partial #{result.inspect}"
		render html: result if result
	end

	def partial
		req_host = params[:req_host]
		partial_name = params[:partial_name]
		subdomain_config = Odania.plugin.get_subdomain_config(req_host)

		el_partial_name = get_partial_template subdomain_config['partials'][partial_name]
		result = render_direct_page 'partial', req_host, el_partial_name, subdomain_config
		return error if result.nil?
		render html: result
	end

	def error
		@error_msg = 'Sorry.... we could not find the requested page.' if @error_msg.nil?

		response.headers['X-Do-Esi'] = true
		render status: :not_found, action: :error
	end

	private

	def render_direct_page(type, req_host, path, subdomain_config, data={})
		domain_info = PublicSuffix.parse(req_host)
		domain = domain_info.domain

		result = get_entry_by_path(type, domain, req_host, path)
		total_hits = result['total']
		logger.info "total_hits: #{total_hits}"

		return nil if total_hits.eql? 0
		hits = result['hits']
		hit = hits.first
		template = hit['_source']['content']

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, subdomain_config, build_domain_query(domain, req_host), data)
		odania_template.render.html_safe
	end

	def get_entry_by_path(type, domain, req_host, path)
		must_query = 'web'.eql?(type) ? [{term: {released: true}}, {term: {path: path}}] : [{term: {partial_name: path}}]

		query = {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: build_filtered_domain_query(domain, req_host, {
				bool: {
					must: must_query
				}
			})
		}

		logger.info query

		search type, query
	end

	def get_partial_template(partial)
		return '' if partial.nil?
		partial['template']
	end
end
