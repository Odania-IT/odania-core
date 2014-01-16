module OdaniaCore
	module Controllers
		module Helpers
			#extend ActiveSupport::Concern

			# Define authentication filters and accessor helpers.
			# These filters should be used inside the controllers as before_filters,
			#
			#   Generated methods:
			#     authenticate_user!  # Signs user in or redirect
			#     user_signed_in?     # Checks whether there is a user signed in or not
			#     current_user        # Current signed in user
			#     user_session        # Session data available only to the user scope
			#
			#   Use:
			#     before_filter :authenticate_user!
			#
			def self.define_helpers(config)
				module_eval <<-METHODS, __FILE__, __LINE__ + 1
					def user_signed_in?
						#{config.user_signed_in_function}
					end

					def current_user
						#{config.current_user_function}
					end
				METHODS

				puts '------------------------------------------------------------------------'
				puts "YES I AM CALLED"
				puts config.inspect
				puts self.inspect
				puts '------------------------------------------------------------------------'

				ActiveSupport.on_load(:action_controller) do
					helper_method 'current_user', 'user_signed_in?'
					puts '+++++++++++++++++++++++++'
					puts "YES I AM CALLED"
					puts user_signed_in?
					puts "asdasd"
					puts current_user
					puts '+++++++++++++++++++++++++'
				end
			end
		end
	end
end
