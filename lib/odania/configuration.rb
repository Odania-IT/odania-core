module Odania
	class Configuration
		# This function needs to return a boolean if a user is currently signed in
		mattr_accessor :user_signed_in_function

		# This function needs to return the current user
		mattr_accessor :current_user_function

		# Before filter checking if a user is authenticated
		mattr_accessor :authenticate_user_function

		mattr_accessor :page_404
		@@page_404 = {template: 'odania/common/not_found_error', layout: 'layouts/odania_core/error'}
	end
end
