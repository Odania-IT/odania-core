class Odania::UserDevice < ActiveRecord::Base
	belongs_to :user, class_name: 'Odania::User'

	before_create do
		self.token = SecureRandom.hex(128)

		true
	end
end
