require "odania_core/engine"

module OdaniaCore
	module Controllers
		autoload :Helpers, 'odania_core/controllers/helpers'
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
end
