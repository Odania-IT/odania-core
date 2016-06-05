require 'odania'

class TemplateController < ApplicationController
	include EntryConcern

	def page
		global_config = Odania.plugin.get_global_config
		req_host = params[:req_host]
		req_url = params[:req_url]

		domain_info = PublicSuffix.parse(req_host)
		domain = domain_info.domain

		# Do we have a direct hit?
		result = get_entry_by_path('web', domain, req_host, req_url)
		total_hits = result['total']
		esi_action = 'content'

		if total_hits.eql? 0
			esi_action = 'list_view'
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
				query: build_domain_query(domain, req_host, {
					bool: {
						must: [
							{prefix: {path: req_url}},
							{term: {released: true}}
						]
					}
				})
			}
			result = search 'web', query
			total_hits = result['total']
		end

		logger.info total_hits

		hits = result['hits']
		hits.each do |hit|
			source = hit['_source']
			logger.info "Hit: [#{hit['_score']}] #{source['full_domain']} #{source['full_path']} | #{source['path']}"
		end


		return error if total_hits.eql? 0

		# Identify layout
		selected_layout = get_layout_name global_config, domain_info.domain, domain_info.trd
		layout_file = '/application.html'
		logger.info "Selected Layout: '#{selected_layout}' [layouts/#{selected_layout}#{layout_file}]"

		result = $elasticsearch.search index: 'odania', type: 'partial', body: {
			query: {
				bool: {
					should: [
						{match: {full_domain: {query: req_host, boost: 10}}},
						{match: {full_domain: {query: domain, boost: 6}}},
						{match: {domain: '_general'}}
					],
					must: [
						{term: {partial_name: "layouts/#{selected_layout}#{layout_file}"}}
					]
				}
			}
		}

		total_hits = result['hits']['total']
		logger.info "Layout total hits: #{total_hits}"

		hits = result['hits']['hits']
		hit = hits.first
		source = hit['_source']
		logger.info "Layout Best Hit: [#{hit['_score']}] #{source['full_domain']} #{source['full_path']}"
		template = source['content']

		return error if template.nil?

		partials = {
			'content' => "http://internal.core/template/#{esi_action}?req_url=#{req_url}&domain=#{domain}&req_host=#{req_host}&layout=#{selected_layout}"
		}

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, 'NOT-PROVIDED', req_host)
		render html: odania_template.render.html_safe
	end

	def content
		render_direct_page 'web'
	end

	def partial
		render_direct_page 'partial'
	end

	def list_view
		req_host = params[:req_host]
		req_url = params[:req_url]

		domain_info = PublicSuffix.parse(req_host)
		@domain = domain_info.domain

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
		logger.info query
		logger.info result.inspect
		@total_hits = result['total']
		@hits = result['hits']

		response.headers['X-Do-Esi'] = true
		#odania_template = OdaniaCore::Erb.new(template, domain, partials, 'NOT-PROVIDED', req_host)
		#render html: odania_template.render.html_safe
	end

	def error
		render status: :not_found, action: :error
	end

	private

	def render_direct_page(type)
		req_host = params[:req_host]
		req_url = params[:req_url]

		domain_info = PublicSuffix.parse(req_host)
		domain = domain_info.domain

		result = get_entry_by_path(type, domain, req_host, req_url)
		total_hits = result['total']

		return error if total_hits.eql? 0
		hits = result['hits']['hits']
		hit = hits.first
		template = hit['content']

		partials = {}
		"[#{type}] params #{params.inspect} template: #{template.inspect} req_url: #{req_url}"

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, 'NOT-PROVIDED', req_host)
		render html: odania_template.render.html_safe
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

	def get_entry_by_path(type, domain, req_host, req_url)
		query = {
			from: 0,
			size: 10,
			sort: {
				_score: 'desc'
			},
			query: build_domain_query(domain, req_host, {
				bool: {
					must: [
						{term: {path: req_url}},
						{term: {released: true}}
					]
				}
			})
		}
		search type, query
	end
end
