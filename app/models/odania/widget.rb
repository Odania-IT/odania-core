class Odania::Widget < ActiveRecord::Base
	belongs_to :site, inverse_of: :default_widget

	serialize :content, Hash

	validates_length_of :name, minimum: 1

	before_create do
		self.is_global = false if self.is_global.nil?

		true
	end
end
