require 'odania'

class TemplateController < ApplicationController
	session :off

	INTERNAL_VARNISH_IP = '127.0.0.1'
	INTERNAL_VARNISH_PORT = 80

	def page
		puts params.inspect
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]
		req_url = params[:req_url]

		global_config = Odania.plugin.get_global_config

		domain_info = PublicSuffix.parse(req_host)
		selected_layout = get_layout_name global_config, domain_info.domain, domain_info.trd

		layout_config = find_layout global_config, selected_layout, domain_info.domain, domain_info.trd
		get_url = params[:plugin_url]
		if layout_config.nil?
			logger.info 'KEINE CONFIG'
		else
			get_url = get_layout_file layout_config, layout_config['styles']['_general']['entry_point']
		end

		uri = URI.parse("http://#{group_name}.internal/#{get_url}")

		template = get_from_internal_varnish uri, req_host

		partials = {
			'content' => "http://internal.core/template/content?req_url=#{req_url}&domain=#{domain}&plugin_url=#{params[:plugin_url]}&group_name=#{group_name}&req_host=#{req_host}"
		}

		odania_template = OdaniaCore::Erb.new(template, domain, partials, group_name, req_host)
		render html: odania_template.render.html_safe
	end

	def content
		puts params.inspect
		req_host = params[:req_host]
		domain = params[:domain]
		group_name = params[:group_name]

		puts params[:plugin_url].inspect

		uri = URI.parse("http://#{group_name}.internal#{params[:plugin_url]}")

		template = get_from_internal_varnish uri, req_host

		#response = Net::HTTP.get(uri)
		#$logger.info template.inspect
		partials = {}
		"Page, it's #{params.inspect} at the server! <br/>#{template.inspect} <br/> #{uri} <br/>end"

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

		template = get_from_internal_varnish uri, req_host
		partials = {}

		odania_template = OdaniaCore::Erb.new(template, domain, partials, group_name, req_host)
		render html: odania_template.render.html_safe
	end

	def error
	end

	private

	def get_from_internal_varnish(uri, original_host)
		logger.info "Retrieve from internal varnish: #{uri}"

		template = ''
		Net::HTTP.new(uri.host, uri.port, INTERNAL_VARNISH_IP, INTERNAL_VARNISH_PORT).start do |http|
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
		return file_data['plugin_url'] unless file.nil?

		file_data = retrieve_hash_path layout_config, ['styles', '_general', 'dynamic', file]
		return file_data['plugin_url'] unless file.nil?

		'Sorry.... we could not retrieve the layout :('
	end

	def retrieve_hash_path(hash, path)
		key = path.shift

		return nil until hash.has_key? key
		return hash[key] if path.empty?
		retrieve_hash_path hash[key], path
	end
end
