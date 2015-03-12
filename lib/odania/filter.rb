require 'nokogiri'

module Odania
	module Filter
		class << self
			include Rails.application.routes.url_helpers

			def filter_html(obj, html, host)
				# Add nofollow to links
				doc = Nokogiri::HTML.fragment(html)
				doc.css('a').each do |link|
					unless link.attributes['href'].nil?
						link.attributes['href'].value = get_click_counter_url(obj, link.attributes['href'].value, host)
						link['rel'] = 'nofollow'
					end
				end

				return doc.to_s
			end

			def get_click_counter_url(obj, target_url, host)
				deliver_click_url(type: obj.class.to_s, id: obj.id.to_s, target: Rack::Utils.escape(target_url), host: host)
			end
		end
	end
end
