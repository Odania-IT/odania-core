require 'odania'

module OdaniaCore
	class Engine < ::Rails::Engine
		initializer "odania_core.url_helpers" do
			::Odania.include_helpers(::Odania::Controllers)
		end

		config.generators do |g|
			g.orm :mongoid
			g.template_engine :erb
			g.test_framework :factory_girl
		end
	end
end
