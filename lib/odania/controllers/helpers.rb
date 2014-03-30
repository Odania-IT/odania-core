require 'action_controller/metal/exceptions'

module Odania
	module Controllers
		module Helpers

			# before_filter to make sure that we have a valid site
			def valid_site!
				if current_site.nil?
					site = Site.active.where(is_default: true).first
					return redirect_to "http://#{site.host}" unless site.nil?

					render :text => 'There is no (default)-site defined!', status: :service_unavailable
					return false
				end

				unless current_site.redirect_to.nil?
					return redirect_to "http://#{current_site.redirect_to.host}"
				end

				if current_menu.nil?
					site = Site.active.where(is_default: true).first
					return redirect_to "http://#{site.host}" unless site.nil?

					render :text => 'There is no (default)-site defined!', status: :service_unavailable
					return false
				end

				return true
			end

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
					helper Odania::Controllers::Helpers

					helper_method :user_signed_in?, :current_user
				end
			end

			# Raise a not found exception
			def not_found
				render :template => 'error_pages/404', :layout => false, :status => :not_found
			end

			# Set layout depending on the current site
			def set_layout
				current_site.template || 'odania_core/application'
			end
		end
	end
end
