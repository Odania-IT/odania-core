class Odania::User < ActiveRecord::Base
	validates_length_of :name, minimum: 3, maximum: 20
	validates_uniqueness_of :name, :scope => [:site_id]
	validates_uniqueness_of :email, :scope => [:site_id]

	has_many :roles, class_name: 'Odania::UserRole'
	belongs_to :site, class_name: 'Odania::Site'
end
