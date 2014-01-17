require "odania_core/engine"

module OdaniaCore
	module Controllers
		autoload :Helpers, 'odania_core/controllers/helpers'
    autoload :UrlHelpers, 'odania_core/controllers/url_helpers'
	end

	autoload :Configuration, 'odania_core/configuration'

	# Define a set of helpers that are called on setup.
	mattr_reader :helpers
	@@helpers = Set.new
	@@helpers << OdaniaCore::Controllers::Helpers

	# Configure the Odania Portal, example for an initializer:
	#
	# OdaniaCore.configure do |config|
	#    config.user_signed_in_function = 'signed_in?'
	# end
	#
	# This examples shows only a part of the configuration possibilities
	def self.setup
		yield OdaniaCore::Configuration
		@@helpers.each { |h| h.define_helpers(self.config) }
	end

	# Retrieve configuration
	def self.config
		OdaniaCore::Configuration
	end

  # Include helpers in the given scope to AC and AV.
  def self.include_helpers(scope)
    ActiveSupport.on_load(:action_controller) do
      include scope::Helpers if defined?(scope::Helpers)
      include scope::UrlHelpers
    end

    ActiveSupport.on_load(:action_view) do
      include scope::UrlHelpers
    end
  end
end
