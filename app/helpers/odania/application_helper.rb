module Odania
	module ApplicationHelper
		def format_date(date)
			return '' if date.nil?
			date.strftime('%d.%m.%Y')
		end

		def list_languages(languages)
			result = []
			languages.each do |language|
				result << language.iso_639_1
			end
			result.join(', ')
		end

		def icon_for_bool(b)
			return '<span class="fa fa-check"></span>'.html_safe if b
			'<span class="fa fa-times"></span>'.html_safe
		end

		def star_icon_for_bool(b)
			return '<span class="fa fa-star"></span>'.html_safe if b
			'<span class="fa fa-star-o"></span>'.html_safe
		end

		def language_flag(language)
			(image_tag("flags/#{language.flag_image}", alt: language.iso_639_1, height: 20) + " #{language.name}").html_safe
		end

		def date_to_time_since_epoch(date)
			return nil if date.nil?
			return date.to_i * 1000 if date.is_a?(Time)
			date.strftime('%Q')
		end
	end
end