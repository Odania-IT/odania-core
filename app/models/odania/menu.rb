class Odania::Menu < ActiveRecord::Base
	has_one :default_menu_item, class_name: 'Odania::MenuItem'
	belongs_to :site, class_name: 'Odania::Site'
	belongs_to :language, class_name: 'Odania::Language'
	has_many :menu_items, class_name: 'Odania::MenuItem'

	validates_length_of :title, minimum: 2
	validates_uniqueness_of :site_id, scope: :language_id

	def get_locale
		return language.iso_639_1 unless language.nil?
		return Odania::Language.first.iso_639_1
	end

	def get_target_path
		"/#{self.prefix}"
	end

	before_save do
		self.prefix = self.language.iso_639_1 if (self.prefix.nil? or self.prefix.blank?) and !self.language.nil?

		return true
	end
end
