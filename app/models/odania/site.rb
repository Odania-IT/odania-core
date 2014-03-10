module Odania
	class Site
		include Mongoid::Document
		include Mongoid::Timestamps

		field :name, type: String
		field :host, type: String
		field :is_active, type: Mongoid::Boolean, default: true
		field :is_default, type: Mongoid::Boolean, default: false
		field :tracking_code, type: String
		field :description, type: String
		field :template, type: String

		# Are users allowed to signup. Otherwise only admins create accounts.
		field :user_signup_allowed, type: Mongoid::Boolean, default: false

		# SEO
		field :keywords, type: String

		has_and_belongs_to_many :languages, inverse_of: nil, :class_name => 'Odania::Language'
		belongs_to :default_language, :class_name => 'Odania::Language'
		belongs_to :redirect_to, :class_name => 'Odania::Site'
		has_many :menus, :class_name => 'Odania::Menu'
		has_many :contents, :class_name => 'Odania::Content'

		scope :active, -> { where(is_active: true) }

		validates_uniqueness_of :host, :name
		validates_length_of :host, minimum: 4
		validate :validate_template_exists, :validate_language_is_present
		validates_presence_of :host, :name

		def self.get_site(host)
			Odania::Site.active.where(host: host).first
		end

		attr_accessor :menu_cache
		def get_current_menu(locale)
			self.menu_cache = {} if self.menu_cache.nil?
			return self.menu_cache[locale] unless self.menu_cache[locale].nil?

			language = Odania::Language.where(iso_638_1: locale).first
			language = self.default_language if language.nil?

			current_menu = self.menus.where(language_id: language.id).first unless locale.nil?
			current_menu = self.menus.build if current_menu.nil?

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
				self.language_ids << self.default_language_id
			end

			if self.language_ids.empty?
				if self.default_language.nil?
					errors.add(:languages, 'select at least one language')
				else
					self.language_ids << self.default_language_id
				end
			end

			unless self.language_ids.include? self.default_language_id
				errors.add(:languages, 'default language has to be in the list of languages')
			end
		end

		def get_template_name
			return '-' if self.template.blank?

			template_info = Odania.templates[self.template]
			return 'error' if template_info.nil?
			template_info[:name]
		end

		before_save do
			self.default_language = self.languages.first if self.default_language.nil?

			return true
		end
	end
end
