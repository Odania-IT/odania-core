class Admin::PreviewController < AdminController
	def index
		global_config = Odania.plugin.get_global_config
		@plugin_config = Odania.plugin.plugin_config.load_global_config global_config
	end

	def show
		@uri = URI.parse params[:uri]
		@result = get_from_varnish @uri

		html_doc = Nokogiri::HTML(@result)

		html_doc.css('a').each do |element|
			href = element['href']

			unless href.nil?
				if href.start_with? 'http'
					target_uri = URI.parse(href)
					href = target_uri.query
				end

				href = "/#{href}" unless href.nil? or href.start_with? '/'
				href = admin_preview_show_path(uri: "http://#{@uri.host}#{href}")
				element['href'] = href
			end
		end

		render html: html_doc.to_xhtml(indent: 3).html_safe
	end

	private

	def get_varnish
		Odania.consul.service.get 'odania-varnish'
	end

	def get_from_varnish(uri)
		start = Time.now
		logger.info "Retrieve from varnish: #{uri}"
		varnish = get_varnish

		response = nil
		begin
			Net::HTTP.new(uri.host, uri.port, varnish.ServiceAddress, varnish.ServicePort).start do |http|
				http.read_timeout = 2
				request = Net::HTTP::Get.new uri
				response = http.request request
			end
		rescue => e
			logger.error "Exception: #{uri} | #{e}"
			throw e
		end

		diff = Time.now - start
		logger.info "TIME #{uri}: #{diff}s"

		case response
			when Net::HTTPSuccess then
				logger.info response.inspect
				template = response.body
				return template.html_safe
			when Net::HTTPRedirection then
				logger.info "#{uri} Going to #{response['location']}"
				return get_from_varnish build_uri_for uri, response['location']
			else
				return response.body.html_safe if 404.eql? response.code.to_i
				logger.info "#{uri} #{response.code}"
				logger.info response.inspect
				return response.error!
		end
	end

	def build_uri_for(orig_uri, path)
		return URI.parse(path) if path.start_with? 'http'
		URI.parse("#{orig_uri.scheme}://#{orig_uri.host}:#{orig_uri.port}#{path}")
	end
end
