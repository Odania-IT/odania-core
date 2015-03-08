class Odania::Category < ActiveRecord::Base
	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	belongs_to :user, :class_name => 'Odania::User'

	validates_length_of :title, minimum: 1

	before_create do
		self.count = 0 if self.count.nil?

		true
	end
end
