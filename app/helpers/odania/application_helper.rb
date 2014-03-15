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

		def icon_for_bool(b)
			return '<span class="glyphicon glyphicon-ok"></span>'.html_safe if b
			'<span class="glyphicon glyphicon-remove"></span>'.html_safe
		end

		def star_icon_for_bool(b)
			return '<span class="glyphicon glyphicon-star"></span>'.html_safe if b
			'<span class="glyphicon glyphicon-star-empty"></span>'.html_safe
		end
	end
end
