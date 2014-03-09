class Odania::User
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :admin_layout, type: String

	validates_length_of :name, minimum: 3, maximum: 20
end
