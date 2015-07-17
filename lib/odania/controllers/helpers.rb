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
					redirect_to "http://#{current_site.redirect_to.host}"
					return false
				end

				return true
			end

			def valid_menu!
				if current_menu.nil?
					render template: Odania.config.page_404[:template], layout: Odania.config.page_404[:layout]
					return false
				end

				return true
			end

			def require_admin_role!
				return false unless user_signed_in?
				return redirect_to root_path, notice: t('Not allowed') unless current_user.admin?
			end

			# Define accessor helpers.
			def self.define_helpers(config)
				# Register helpers automatically after loading of action_controller
				ActiveSupport.on_load(:action_controller) do
					helper Odania::Controllers::Helpers
				end
			end

			# Raise a not found exception
			def render_not_found
				render template: Odania.config.page_404[:template], layout: Odania.config.page_404[:layout], status: :not_found
			end

			# Raise an error
			def render_error(err_msg=nil)
				@error_msg = err_msg
				render template: 'odania/common/internal_server_error', layout: 'layouts/odania_core/error', status: :bad_request
			end

			# Set layout depending on the current site
			def set_layout
				tpl = current_site.nil? ? nil : current_site.template
				tpl || 'odania_core/application'
			end
		end
	end
end
