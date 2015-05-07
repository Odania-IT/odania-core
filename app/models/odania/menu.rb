class Odania::Menu < ActiveRecord::Base
	has_one :default_menu_item, class_name: 'Odania::MenuItem'
	belongs_to :site, class_name: 'Odania::Site', touch: true
	belongs_to :language, class_name: 'Odania::Language'
	has_many :menu_items, class_name: 'Odania::MenuItem', dependent: :destroy

	validates_presence_of :language_id
	validates_uniqueness_of :site_id, scope: :language_id

	def get_locale
		return language.iso_639_1 unless language.nil?
		return Odania::Language.first.iso_639_1
	end

	def get_target_path
		"/#{self.language.iso_639_1}"
	end

	before_create do
		self.display_categories = true if self.display_categories.nil?

		true
	end
end
