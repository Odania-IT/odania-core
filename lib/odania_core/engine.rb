# Require dependent gems
require 'rubygems'
require 'paperclip'
require 'sanitize'
require 'http_accept_language'
require 'kaminari'
require 'sass-rails'
require 'coffee-rails'
require 'jquery-rails'
require 'bootstrap-sass'
require 'rails-i18n'
require 'autoprefixer-rails'
require 'angularjs-rails'
require 'angular-ui-bootstrap-rails'
require 'jbuilder'
require 'responders'
require 'font-awesome-rails'
require 'uglifier'
require 'rack/cors'
require 'oj'
require 'devise'
require 'devise-encryptable'
require 'omniauth'
require 'omniauth-openid'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'omniauth-google-oauth2'

# Require internals
require 'odania'
require 'viewable'

module OdaniaCore
	class Engine < ::Rails::Engine
		initializer 'odania_core.url_helpers' do
			::Odania.include_helpers(::Odania::Controllers)
		end

		config.generators do |g|
			g.template_engine :erb
			g.test_framework :factory_girl
		end

		initializer 'odania_core.middleware' do |app|
			app.config.app_middleware.insert_before 0, 'Rack::Cors' do
				allow do
					origins '*'
					resource '*/api/*', :headers => :any, :methods => [:get, :post, :put, :options, :delete, :patch]
				end
			end
		end
	end
end
