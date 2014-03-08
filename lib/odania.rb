module Odania
	module Controllers
		autoload :Helpers, 'odania/controllers/helpers'
		autoload :UrlHelpers, 'odania/controllers/url_helpers'
	end

	autoload :Configuration, 'odania/configuration'

	# Define a set of helpers that are called on setup.
	mattr_reader :helpers
	@@helpers = Set.new
	@@helpers << Odania::Controllers::Helpers

	# Configure the Odania Portal, example for an initializer:
	#
	# Odania.configure do |config|
	#    config.user_signed_in_function = 'signed_in?'
	# end
	#
	# This examples shows only a part of the configuration possibilities
	def self.setup
		yield Odania::Configuration
		@@helpers.each { |h| h.define_helpers(self.config) }

		# Enqueue for background processing
		if Odania.config.background_enqueue.blank?
			Rails.logger.error 'No background_enqueue defined!'
			Odania.config.background_enqueue = 'puts \'FallbackEnqueue\';puts'
		end
		module_eval <<-METHODS, __FILE__, __LINE__ + 1
			def self.enqueue(background_type, opts)
				#{Odania.config.background_enqueue}(background_type, opts)
			end
		METHODS
	end

	# Retrieve configuration
	def self.config
		Odania::Configuration
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

	# Registered Templates
	mattr_reader :templates
	@@templates = Hash.new

	def self.templates_for_select
		result = []

		self.templates.each_value do |template|
			result << [template[:name], template[:template]]
		end
		result
	end

	# Trackable classes. Only these classes are accepted in deliver/click and will increase the counter
	mattr_reader :trackable_classes
	@@trackable_classes = Set.new
	@@trackable_classes << 'Content'
end
