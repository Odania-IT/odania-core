require 'rack/cors'

module Odania
	class Engine < ::Rails::Engine
		initializer 'odania.middleware' do |app|
			app.config.app_middleware.insert_before 0, Rack::Cors do
				allow do
					origins '*'
					resource '*/api/*', :headers => :any, :methods => [:get, :post, :put, :options, :delete, :patch]
				end
			end
		end
	end
end
