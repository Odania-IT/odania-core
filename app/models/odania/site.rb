module Odania
	class Site
		include Mongoid::Document
		include Mongoid::Timestamps

		field :name, type: String
		field :host, type: String
		field :is_active, type: Mongoid::Boolean, default: true
		field :is_default, type: String, default: false
		field :tracking_code, type: String
		field :description, type: String
		field :template, type: String

		# Are users allowed to signup. Otherwise only admins create accounts.
		field :user_signup_allowed, type: Mongoid::Boolean, default: false

		# SEO
		field :keywords, type: String

		belongs_to :language, :class_name => 'Odania::Language'
		belongs_to :redirect_to, :class_name => 'Odania::Site'
		has_many :menus, :class_name => 'Odania::Menu'
		has_many :contents, :class_name => 'Odania::Content'

		scope :active, -> { where(is_active: true) }

		validates_uniqueness_of :host, :name
		validates_length_of :host, minimum: 4
		validate :validate_template_exists

		def self.get_site(host)
			Site.active.where(host: host).first
		end

		attr_accessor :menu_cache
		def get_current_menu(language)
			iso_639_1 = language.nil? ? '' : language.iso_639_1
			self.menu_cache = {} if self.menu_cache.nil?
			return self.menu_cache[iso_639_1] unless self.menu_cache[iso_639_1].nil?

			current_menu = self.menus.where(language_id: language.id).first unless language.nil?
			current_menu = self.menus.where(is_default_menu: true).first if current_menu.nil?
			current_menu = self.menus.build if current_menu.nil?

			self.menu_cache[iso_639_1] = current_menu
			return current_menu
		end

		def validate_template_exists
			if !self.template.nil? and !Odania.templates.include?(self.template)
				errors.add(:template, 'invalid template')
			end
		end
	end
end
