module Odania
	module ApplicationHelper
		def format_date(datum)
			if datum.nil? then
				return '';
			end

			return datum.strftime('%d.%m.%Y')
		end
	end
end
