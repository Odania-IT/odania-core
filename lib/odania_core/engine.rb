module OdaniaCore
  class Engine < ::Rails::Engine
    isolate_namespace OdaniaCore

    initializer "odania_core.url_helpers" do
      OdaniaCore.include_helpers(OdaniaCore::Controllers)
    end
  end
end
