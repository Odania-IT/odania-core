class Odania::MenuItem
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :published, type: Mongoid::Boolean
	field :is_default_page, type: Mongoid::Boolean

	field :target_type, type: String, default: Odania::TargetType::URL
	field :target_data, type: Hash, default: {}

	belongs_to :parent, :class_name => 'Odania::MenuItem'
	embedded_in :menu, :class_name => 'Odania::Menu'

	validates_presence_of :title, minimum: 1
end
