class Odania::Menu
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :published, type: Mongoid::Boolean, default: true
	field :is_default_menu, type: Mongoid::Boolean, default: false

	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	embeds_many :menu_items, :class_name => 'Odania::MenuItem'

	validates_presence_of :title, minimum: 2
	validates_uniqueness_of :site_id, scope: :language_id
	index({site_id: 1, language_id: 1}, {unique: true})
end
