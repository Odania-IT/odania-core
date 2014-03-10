module Odania
	module ApplicationHelper
		def format_date(datum)
			if datum.nil? then
				return '';
			end

			return datum.strftime('%d.%m.%Y')
		end

		def list_languages(languages)
			result = []
			languages.each do |language|
				result << language.iso_639_1
			end
			result.join(', ')
		end
	end
end
