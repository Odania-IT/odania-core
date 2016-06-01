require 'odania'

class TemplateController < ApplicationController
	INTERNAL_PROXY_IP = '127.0.0.1'
	INTERNAL_PROXY_PORT = 80

	def page
		puts params.inspect
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]
		req_url = params[:req_url]

		result = $elasticsearch.search index: 'odania', type: 'web', body: {
			query: {
				bool: {
					should: [
						{match: {full_path: req_host}},
						{match: {full_path: domain}},
						{match: {full_path: ''}}
					],
					must: [
						{match: {path: req_url}}
					]
				}
			}
		}

		puts result.inspect

=begin
		2.2.4 :013 > c.count index: 'odania', body: { query: { bool: { must: [ {match: {domain: 'die-information.eu'}}, {match: {subdomain: 'auto'}}] }}}
		2016-05-30 23:03:19 +0200: GET http://172.19.0.9:9200/odania/_count [status:200, request:0.008s, query:n/a]
		2016-05-30 23:03:19 +0200: > {"query":{"bool":{"must":[{"match":{"domain":"die-information.eu"}},{"match":{"subdomain":"auto"}}]}}}
		2016-05-30 23:03:19 +0200: < {"count":8,"_shards":{"total":5,"successful":5,"failed":0}}
		 => {"count"=>8, "_shards"=>{"total"=>5, "successful"=>5, "failed"=>0}}
		2.2.4 :014 > c.count index: 'odania', body: { query: { bool: { should: [ {match: {domain: 'die-information.eu'}}, {match: {subdomain: 'auto'}}] }}}
		2016-05-30 23:03:28 +0200: GET http://172.19.0.9:9200/odania/_count [status:200, request:0.005s, query:n/a]
		2016-05-30 23:03:28 +0200: > {"query":{"bool":{"should":[{"match":{"domain":"die-information.eu"}},{"match":{"subdomain":"auto"}}]}}}
		2016-05-30 23:03:28 +0200: < {"count":74,"_shards":{"total":5,"successful":5,"failed":0}}
		 => {"count"=>74, "_shards"=>{"total"=>5, "successful"=>5, "failed"=>0}}
=end
	end

	def old_page
		puts params.inspect
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]
		req_url = params[:req_url]

		global_config = Odania.plugin.get_global_config

		domain_info = PublicSuffix.parse(req_host)
		selected_layout = get_layout_name global_config, domain_info.domain, domain_info.trd
		logger.info "Selected Layout: '#{selected_layout}'"

		layout_config = find_layout global_config, selected_layout, domain_info.domain, domain_info.trd
		get_url = params[:plugin_url]
		if layout_config.nil?
			logger.info 'KEINE CONFIG'
		else
			get_url = get_layout_file layout_config, layout_config['styles']['_general']['entry_point']

			return render text: "Sorry.... we could not retrieve the layout :(\n'#{selected_layout}'" if get_url.nil?
		end

		uri = URI.parse("http://#{group_name}.internal#{get_url}")

		template = get_from_internal_proxy uri, req_host

		partials = {
			'content' => "http://internal.core/template/content?req_url=#{req_url}&domain=#{domain}&plugin_url=#{params[:plugin_url]}&group_name=#{group_name}&req_host=#{req_host}"
		}

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, group_name, req_host)
		render html: odania_template.render.html_safe
	end

	def content
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]

		puts params[:plugin_url].inspect

		uri = URI.parse("http://#{group_name}.internal#{params[:plugin_url]}")

		template = get_from_internal_proxy uri, req_host

		#response = Net::HTTP.get(uri)
		#$logger.info template.inspect
		partials = {}
		"Page, it's #{params.inspect} at the server! <br/>#{template.inspect} <br/> #{uri} <br/>end"

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, group_name, req_host)
		render html: odania_template.render.html_safe
	end

	def partial
		puts params.inspect
		partial_name = params[:partial_name]
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]

		puts params[:plugin_url].inspect

		uri = URI.parse("http://#{group_name}.internal#{params[:plugin_url]}")

		template = get_from_internal_proxy uri, req_host
		partials = {}

		response.headers['X-Do-Esi'] = true
		odania_template = OdaniaCore::Erb.new(template, domain, partials, group_name, req_host)
		render html: odania_template.render.html_safe
	end

	def error
		render status: :not_found
	end

	private

	def get_from_internal_proxy(uri, original_host)
		logger.info "Retrieve from internal proxy: #{uri}"

		template = ''
		Net::HTTP.new(uri.host, uri.port, INTERNAL_PROXY_IP, INTERNAL_PROXY_PORT).start do |http|
			request = Net::HTTP::Get.new uri
			request['X-Original-Host'] = original_host
			response = http.request request

			logger.info response.inspect
			template = response.body
		end
		template.html_safe
	end

	def find_layout(global_config, selected_layout, domain, subdomain)
		# subdomain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, subdomain, 'internal', 'layouts', selected_layout]
		return result unless result.nil?

		# domain specific layouts
		result = retrieve_hash_path global_config, ['domains', domain, '_general', 'internal', 'layouts', selected_layout]
		return result unless result.nil?

		# general layouts
		result = retrieve_hash_path global_config, ['domains', '_general', '_general', 'internal', 'layouts', selected_layout]
		return result unless result.nil?

		{}
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

	def get_layout_file(layout_config, file)
		file_data = retrieve_hash_path layout_config, ['styles', '_general', 'direct', file]
		return file_data['plugin_url'] unless file_data.nil?

		file_data = retrieve_hash_path layout_config, ['styles', '_general', 'dynamic', file]
		return file_data['plugin_url'] unless file_data.nil?

		nil
	end

	def retrieve_hash_path(hash, path)
		key = path.shift

		return nil until hash.has_key? key
		return hash[key] if path.empty?
		retrieve_hash_path hash[key], path
	end
end
