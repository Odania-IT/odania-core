module OdaniaTestMock
	mattr_accessor :signed_in
	@@signed_in = false

	mattr_accessor :mock_current_user

	def self.current_user
		user = Odania::User.where(name: 'Admin', email: 'mail@example.com').first_or_create

		if user.id.nil?
			user.language_id = 1
			user.save!
		end

		if user.roles.count == 0
			user.roles.create(role: Odania::UserRole.roles[:admin])
		end

		return user
	end

	mattr_accessor :user_authenticated
	@@user_authenticated = false
end

module UserAuthHelper
	def user_auth(opts)
		return redirect_to '/' unless user_signed_in?
	end
end

ActiveSupport.on_load(:action_controller) do
	include UserAuthHelper
end

Odania.setup do |config|
	config.user_signed_in_function = 'OdaniaTestMock.signed_in'
	config.current_user_function = 'OdaniaTestMock.current_user'
	config.authenticate_user_function = 'user_auth'
end
