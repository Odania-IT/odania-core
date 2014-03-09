module Odania
	module Controllers
		# TODO: Better name?
		module UrlHelpers
			# The current site depending on the host, e.g. www.odania.de
			def current_site
				@current_site ||= Odania::Site.active.where(host: request.host_with_port).first
			end
		end
	end
end
