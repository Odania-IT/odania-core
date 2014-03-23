require 'nokogiri'

module Odania
	module Filter
		class << self
			include Rails.application.routes.url_helpers

			def filter_html(obj, html)
				# Add nofollow to links
				doc = Nokogiri::HTML.fragment(html)
				doc.css('a').each do |link|
					link.attributes['href'].value = get_click_counter_url(obj, link.attributes['href'].value)
					link['rel'] = 'nofollow'
				end

				# Retrieve tags
				filtered_html = doc.to_s
				tags = []
				html.gsub(/#[a-z0-9\-]*[^< ]/i) do |match|
					tag = match[1, match.length]
					filtered_html.gsub!(match, "<a href=\"/tags/#{tag.parameterize}\">#{tag}</a>")
					tags << tag
				end

				return tags.join(','), filtered_html
			end

			def get_click_counter_url(obj, target_url)
				deliver_click_url(type: obj.class.to_s, id: obj.id.to_s, target: Rack::Utils.escape(target_url))
			end
		end
	end
end
