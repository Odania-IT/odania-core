module OdaniaCore
  class Engine < ::Rails::Engine
    initializer "odania_core.url_helpers" do
      OdaniaCore.include_helpers(OdaniaCore::Controllers)
    end
  end
end
