class BaseController < ApplicationController
	def index
	end

	def detect_language
		# TODO retrieve from domain
		allowed_languages = %w(de en)
		language = http_accept_language.preferred_language_from(allowed_languages)
		language = allowed_languages.first if language.nil?
		logger.info language.inspect
		redirect_to "/#{language}"
	end

	def identify
		@req_url = params[:req_url]
		@req_host = params[:req_host]
		@domain = params[:domain]
		@subdomain = @req_host.gsub(".#{@domain}", '')

		##@pages = Page.where('(domain = ? OR domain IS NULL) AND (subdomain = ? OR subdomain IS NULL) AND category LIKE ?', @domain, @subdomain, "#{@req_url}%")
		#@pages = Page.where('domain = ? AND subdomain = ? AND category LIKE ?', @domain, @subdomain, "#{@req_url}%")
		@pages = Entry.where(domain: @domain, subdomain: @subdomain, category: Regexp.new("#{@req_url}.*"))
	end

	def health
		render plain: 'OK'
	end
end
