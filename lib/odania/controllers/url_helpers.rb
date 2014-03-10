module Odania
	module Controllers
		# TODO: Better name?
		module UrlHelpers
			# The current site depending on the host, e.g. www.odania.de
			def current_site
				@current_site ||= Odania::Site.active.where(host: request.host_with_port).first
			end

			def current_menu
				@current_menu ||= current_site.get_current_menu(I18n.locale.to_s)
			end
		end
	end
end
