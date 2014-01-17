module OdaniaCore
	module Controllers
		module Helpers
			#extend ActiveSupport::Concern

			# Define authentication filters and accessor helpers.
			#
			#   Generated methods:
			#     authenticate_user!  # Signs user in or redirect
			#     user_signed_in?     # Checks whether there is a user signed in or not
			#     current_user        # Current signed in user
			#
			#   Use:
			#     before_filter :authenticate_user!
			#
			def self.define_helpers(config)
				# Define methods dynamically based on the configuration
				module_eval <<-METHODS, __FILE__, __LINE__ + 1
					def authenticate_user!(opts={})
						#{config.authenticate_user_function}(opts)
					end

					def user_signed_in?
						#{config.user_signed_in_function}
					end

					def current_user
						#{config.current_user_function}
					end
				METHODS

				# Register helpers automatically after loading of action_controller
				ActiveSupport.on_load(:action_controller) do
					helper OdaniaCore::Controllers::Helpers
				end
			end
		end
	end
end
