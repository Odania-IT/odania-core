module OdaniaCore
	class Language
		include Mongoid::Document
		include Mongoid::Timestamps

		field :name, type: String
		field :iso_639_1, type: String
	end
end
