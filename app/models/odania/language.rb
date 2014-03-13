module Odania
	class Language < ActiveRecord::Base
		validates_uniqueness_of :name, :iso_639_1
		validates_length_of :name, minimum: 2
		validates_length_of :iso_639_1, minimum: 2
	end
end
