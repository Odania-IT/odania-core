class Odania::Menu
	include Mongoid::Document
	include Mongoid::Timestamps

	MENU_TOP = 'top_menu'
	MENU_SECOND_COLUMN = 'second_column'
	MENU_THIRD_COLUMN = 'third_column'
	MENU_TYPES = [MENU_TOP, MENU_SECOND_COLUMN, MENU_THIRD_COLUMN]

	field :title, type: String
	field :published, type: Mongoid::Boolean, default: true
	field :menu_type, type: String, default: MENU_TOP

	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	embeds_many :menu_items, :class_name => 'Odania::MenuItem'

	validates_presence_of :title, minimum: 2
	validates_uniqueness_of :site_id, scope: :language_id
	index({site_id: 1, language_id: 1, menu_type: 1}, {unique: true})

	def get_locale
		return language.iso_639_1 unless language.nil?
		return Odania::Language.first.iso_639_1
	end
end
