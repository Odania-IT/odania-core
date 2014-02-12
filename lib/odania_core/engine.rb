module OdaniaCore
	class Engine < ::Rails::Engine
		initializer "odania_core.url_helpers" do
			OdaniaCore.include_helpers(OdaniaCore::Controllers)
		end

		config.generators do |g|
			g.orm :mongoid
			g.template_engine :erb
			g.test_framework :factory_girl
		end
	end
end
