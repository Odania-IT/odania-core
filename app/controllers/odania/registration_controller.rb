class Odania::RegistrationController < Devise::RegistrationsController
	before_action :configure_permitted_parameters

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :name
		devise_parameter_sanitizer.for(:sign_up) << :site_id
	end
end
