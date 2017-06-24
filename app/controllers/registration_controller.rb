class RegistrationController < Devise::RegistrationsController

	private

	def sign_up_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :terms_of_service)
	end

	def account_update_params
		params.require(:user).permit(:password, :password_confirmation, :current_password)
	end
end
