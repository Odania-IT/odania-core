module Odania
	def self.table_name_prefix
		'odania_'
	end

	module Controllers
		autoload :Helpers, 'odania/controllers/helpers'
		autoload :UrlHelpers, 'odania/controllers/url_helpers'
	end

	autoload :Configuration, 'odania/configuration'
	autoload :Admin, 'odania/admin'
	autoload :Protected, 'odania/protected'
	autoload :CoreTargetTypeUtil, 'odania/core_target_type_util'
	autoload :TextHelper, 'odania/text_helper'
	autoload :Taggable, 'odania/taggable'
	autoload :Filter, 'odania/filter'
	autoload :TargetType, 'odania/target_type'
	autoload :AdminConstraint, 'odania/admin_constraint'

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

			layout :set_layout
		end

		ActiveSupport.on_load(:action_view) do
			include scope::UrlHelpers
		end

		ActiveSupport.on_load(:active_record) do
			extend Odania::Taggable
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
	mattr_accessor :trackable_classes
	@@trackable_classes = Set.new
	@@trackable_classes << 'Odania::Content'

	# Registered Widgets
	# Widgets are available for display in side bar
	mattr_accessor :widget_includes
	@@widget_includes = Set.new
	@@widget_includes << 'admin/odania/widgets/content'

	mattr_accessor :widgets
	@@widgets = Set.new
	@@widgets << {
		template: 'odania/widgets/plain_html',
		description: 'HTML content',
		is_array: false,
		parameters: [
			{name: 'HTML Content', key: 'content', type: 'wysiwyg'}
		]
	}
	@@widgets << {
		template: 'odania/widgets/newsletter',
		description: 'Perfect Reach Newsletter',
		is_array: false,
		parameters: [
			{name: 'Header', key: 'header', type: 'text'},
			{name: 'URL', key: 'url', type: 'text'}
		]
	}
	@@widgets << {
		template: 'odania/components/display_sites',
		description: 'Display specified sites',
		is_array: true,
		parameters: [
			{name: 'Sites', key: 'sites', type: 'array', fields: [
				{name: 'Site', key: 'site', type: 'site'}
			]}
		]
	}
	@@widgets << {
		template: 'odania/components/display_links',
		description: 'Display specified links',
		is_array: true,
		parameters: [
			{name: 'Links', key: 'links', type: 'array', fields: [
				{name: 'Name', key: 'name', type: 'text'},
				{name: 'Url', key: 'url', type: 'text'}
			]}
		]
	}

	def self.widgets_for_select
		result = []

		self.widgets.each_value do |widget|
			result << [widget[:description], widget[:template]]
		end
		result
	end

	def self.admin
		Odania::Admin
	end

	def self.protected
		Odania::Protected
	end
end
