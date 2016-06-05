require 'odania'

class TemplateController < ApplicationController
	include EntryConcern

	# Only rendering template might result in 200 instead of 404. Is there a way to let varnish send a 404 if one page fails?
	def page
		global_config = Odania.plugin.get_global_config
		req_host = params[:req_host]
		req_url = params[:req_url]

		domain_info = PublicSuffix.parse(req_host)
		domain = domain_info.domain

		# Is this a valid domain?
		valid_domains = global_config['valid_domains']
		if valid_domains[domain].nil?
			# Redirect to default domain
			default_domains = global_config['default_domains']
			domain = default_domains.keys.first
			subdomain = default_domains[domain].first
			return redirect_to "http://#{subdomain}.#{domain}"
		elsif not valid_domains[domain].include? domain_info.trd
			# Redirect to valid subdomain
			default_domains = global_config['default_domains']
			subdomain = default_domains[domain].nil? ? nil : default_domains[domain].first
			subdomain = valid_domains[domain].first if subdomain.nil?
			return redirect_to "http://#{subdomain}.#{domain}"
		end

		# Identify layout
		selected_layout = get_layout_name global_config, domain_info.domain, domain_info.trd
		style = '_general'
		layout_config = get_layout_config global_config, domain, subdomain, selected_layout
		layout_file = retrieve_hash_path layout_config, ['config', 'styles', style, 'entry_point']
		partial_name = get_layout_partial_name selected_layout, layout_file
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

		partials = {
			'content' => "http://internal.core/template/content?req_url=#{req_url}&domain=#{domain}&req_host=#{req_host}&layout=#{selected_layout}"
		}

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, selected_layout, req_host)
		render html: odania_template.render.html_safe
	end

	def content
		req_host = params[:req_host]
		req_url = params[:req_url]
		layout = params[:layout]

		result = render_direct_page 'web', req_host, req_url, layout
		return render html: result if result

		# Try list view
		global_config = Odania.plugin.get_global_config
		req_host = params[:req_host]
		req_url = params[:req_url]

		domain_info = PublicSuffix.parse(req_host)
		@domain = domain_info.domain

		# Is list view enabled?
		logger.debug "No direct page found for #{req_url} [#{req_host}]"
		render_list_view = get_render_list_view global_config, domain_info
		logger.debug render_list_view.inspect
		return error unless render_list_view

		# Do we have pages belonging under this path?
		query = {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: build_domain_query(@domain, req_host, {
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
		domain = domain_info.domain
		subdomain = domain_info.trd
		layout_config = get_layout_config global_config, domain, subdomain, layout

		unless layout_config.nil?
			style = '_general'
			list_view_template_path = retrieve_hash_path layout_config, ['config', 'styles', style, 'list_view']

			unless list_view_template_path.nil?
				partial_name = get_layout_partial_name layout, list_view_template_path
				logger.info "rendering partial #{partial_name}"
				result = render_direct_page 'partial', req_host, partial_name, layout
				logger.info "rendering partial #{result.inspect}"
				render html: result if result
			end
		end
	end

	def partial
		req_host = params[:req_host]
		partial_name = params[:partial_name]
		layout = params[:layout]

		result = render_direct_page 'partial', req_host, partial_name, layout
		return error if result.nil?
		render html: result
	end

	def error
		@error_msg = 'Sorry.... we could not find the requested page.' if @error_msg.nil?

		response.headers['X-Do-Esi'] = true
		render status: :not_found, action: :error
	end

	private

	def render_direct_page(type, req_host, path, layout)
		domain_info = PublicSuffix.parse(req_host)
		domain = domain_info.domain

		result = get_entry_by_path(type, domain, req_host, path)
		total_hits = result['total']

		return nil if total_hits.eql? 0
		hits = result['hits']
		hit = hits.first
		template = hit['_source']['content']

		partials = {}
		"[#{type}] params #{params.inspect} template: #{template.inspect} req_url: #{path}"

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, layout, req_host)
		odania_template.render.html_safe
	end

	def get_layout_name(global_config, domain, subdomain)
		# subdomain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, subdomain, 'config', 'layout']
		return result unless result.nil?

		# domain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, '_general', 'config', 'layout']
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, %w(domains _general _general config layout)
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, %w(config layout)
		return result unless result.nil?

		'simple'
	end

	def retrieve_hash_path(hash, path)
		key = path.shift

		return nil until hash.has_key? key
		return hash[key] if path.empty?
		retrieve_hash_path hash[key], path
	end

	def get_render_list_view(global_config, domain_info)
		domain = domain_info.domain
		subdomain = domain_info.trd
		# subdomain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, subdomain, 'config', 'render_list_view']
		return result unless result.nil?

		# domain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, '_general', 'config', 'render_list_view']
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, %w(domains _general _general config render_list_view)
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, %w(config render_list_view)
		return result unless result.nil?

		false
	end

	def get_layout_config(global_config, domain, subdomain, layout)
		# subdomain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, subdomain, 'layouts', layout]
		return result unless result.nil?

		# domain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, '_general', 'layouts', layout]
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, ['domains', '_general', '_general', 'layouts', layout]
		return result unless result.nil?

		{}
	end

	def get_entry_by_path(type, domain, req_host, path)
		query = {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: build_domain_query(domain, req_host, {
				bool: {
					must: [
						{term: {path: path}},
						{term: {released: true}}
					]
				}
			})
		}

		search type, query
	end

	def get_layout_partial_name(layout_name, layout_file)
		return "layouts/#{layout_name}#{layout_file}" if '/'.eql? layout_file[0]
		"layouts/#{layout_name}/#{layout_file}"
	end
end
