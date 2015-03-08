# Require dependent gems
require 'rubygems'
require 'paperclip'
require 'sanitize'
require 'http_accept_language'
require 'will_paginate'
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
	end
end
