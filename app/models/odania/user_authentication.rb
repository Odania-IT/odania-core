module OdaniaOmniauthAuthentication
	class UserAuthentication < ActiveRecord::Base
		belongs_to :user, class_name: 'Odania::User'

		def self.find_with_omniauth(auth)
			find_by provider: auth['provider'], uid: auth['uid']
		end

		def self.create_with_omniauth(auth)
			create(provider: auth['provider'], uid: auth['uid'])
		end
	end
end
