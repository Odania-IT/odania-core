require 'uri'

module Odania
	class Site < ActiveRecord::Base
		include Odania::Taggable::TagCount

		serialize :social, JSON
		serialize :meta, JSON
		serialize :additional_parameters, JSON

		belongs_to :default_language, :class_name => 'Odania::Language'
		belongs_to :redirect_to, :class_name => 'Odania::Site'
		has_many :menus, :class_name => 'Odania::Menu', dependent: :delete_all
		has_many :contents, :class_name => 'Odania::Content', dependent: :delete_all
		belongs_to :default_widget, class_name: 'Odania::Widget'

		has_many :tags, class_name: 'Odania::Tag'
		has_many :widgets, class_name: 'Odania::Widget', dependent: :delete_all
		has_many :categories, class_name: 'Odania::Category', dependent: :delete_all
		has_many :static_pages, class_name: 'Odania::StaticPage', dependent: :delete_all
		has_many :site_plugins, class_name: 'Odania::SitePlugin', dependent: :delete_all

		belongs_to :imprint, class_name: 'Odania::StaticPage'
		belongs_to :terms_and_conditions, class_name: 'Odania::StaticPage'

		scope :active, -> { where(is_active: true) }

		validates_uniqueness_of :name
		validates_uniqueness_of :subdomain, scope: [:domain]
		validates_length_of :domain, minimum: 4
		validates_length_of :subdomain, minimum: 1, allow_nil: true
		validates_length_of :name, minimum: 1
		validate :validate_template_exists, :validate_language_is_present
		validates_presence_of :domain, :name
		validate :validate_default_widget

		has_many :users, class_name: 'Odania::User'

		def self.get_site(host)
			Odania::Site.active.where(host: host).first
		end

		attr_accessor :menu_cache

		def validate_default_widget
			if !self.default_widget_id.nil? and !self.id.eql?(self.default_widget.site_id)
				errors.add(:default_widget_id, 'invalid widget')
			end
		end

		def plugin_active?(name)
			@active_plugins = self.site_plugins.pluck(:plugin_name) if @active_plugins.nil?
			@active_plugins.include?(name)
		end

		def get_current_menu(locale)
			self.menu_cache = {} if self.menu_cache.nil?
			return self.menu_cache[locale] unless self.menu_cache[locale].nil?

			language = Odania::Language.where(iso_639_1: locale).first

			current_menu = self.menus.where(language_id: language.id).first unless locale.nil? or language.nil?
			return nil if current_menu.nil?

			self.menu_cache[locale] = current_menu
			return current_menu
		end

		def validate_template_exists
			self.template = nil if ''.eql? self.template
			if !self.template.nil? and !Odania.templates.include?(self.template)
				errors.add(:template, 'invalid template')
			end
		end

		def validate_language_is_present
			if self.default_language_id.nil?
				errors.add(:default_language_id, 'has to be set')
			end
		end

		def get_template_name
			return '-' if self.template.blank?

			template_info = Odania.templates[self.template]
			return 'error' if template_info.nil?
			template_info[:name]
		end

		def get_languages
			langs = []
			self.menus.each do |menu|
				langs << menu.language
			end
			langs
		end

		before_save do
			self.is_active = true if self.is_active.nil?
			self.tracking_code = '' if self.tracking_code.nil?
			self.host = self.subdomain.nil? ? self.domain : "#{self.subdomain}.#{self.domain}"
			self.social = {none: ''} if self.social.nil?
			self.additional_parameters = {none: ''} if self.additional_parameters.nil?
			self.meta = {keywords: ''} if self.meta.nil?

			true
		end

		before_create do
			self.description = '' if self.description.nil?

			true
		end
	end
end
