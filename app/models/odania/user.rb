class Odania::User < ActiveRecord::Base
	validates_length_of :name, minimum: 3, maximum: 20
	validates_uniqueness_of :name
	validates_uniqueness_of :email

	has_many :roles, class_name: 'Odania::UserRole'
end
