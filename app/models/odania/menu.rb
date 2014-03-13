class Odania::Menu
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :published, type: Mongoid::Boolean, default: true
	field :default_menu_item, type: String
	field :prefix, type: String

	belongs_to :site, class_name: 'Odania::Site'
	belongs_to :language, class_name: 'Odania::Language'
	embeds_many :menu_items, class_name: 'Odania::MenuItem'

	validates_length_of :title, minimum: 2
	validates_uniqueness_of :site_id, scope: :language_id
	index({site_id: 1, language_id: 1}, {unique: true})

	def get_locale
		return language.iso_639_1 unless language.nil?
		return Odania::Language.first.iso_639_1
	end
end
