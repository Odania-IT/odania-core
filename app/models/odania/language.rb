module Odania
	class Language
		include Mongoid::Document
		include Mongoid::Timestamps

		field :name, type: String
		field :iso_639_1, type: String

		validates_uniqueness_of :name, :iso_639_1
		validates_length_of :name, minimum: 2
		validates_length_of :iso_639_1, minimum: 2

		index({iso_639_1: 1}, {unique: true})
	end
end
