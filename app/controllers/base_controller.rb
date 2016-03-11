class BaseController < ApplicationController
	session :off

	def index
	end

	def detect_language
		language = env.http_accept_language.preferred_language_from(%w(de en))
		redirect_to "/#{language}"
	end

	def health
		render plain: 'OK'
	end
end
