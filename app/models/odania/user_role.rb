class Odania::UserRole < ActiveRecord::Base
	enum role: {user: 0, admin: 1}

	belongs_to :user, class_name: 'Odania::User'
end
