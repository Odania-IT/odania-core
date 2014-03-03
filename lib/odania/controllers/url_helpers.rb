module Odania
	module Controllers
		# TODO: Better name?
		module UrlHelpers
			# The current site depending on the host, e.g. www.odania.de
			def current_site
				@@current_site ||= Site.active.where(host: request.host).first
			end
		end
	end
end
