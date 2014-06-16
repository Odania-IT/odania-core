module Odania
	module Controllers
		# TODO: Better name?
		module UrlHelpers
			# The current site depending on the host, e.g. www.odania.de
			def current_site
				@current_site ||= Odania::Site.active.where(host: request.host_with_port).first
			end

			def current_menu
				cur_locale = params[:locale]
				if cur_locale.nil?
					cur_locale = current_site.default_language.iso_639_1
				end

				@current_menu ||= current_site.get_current_menu(cur_locale)
				unless @current_menu.nil?
					I18n.locale = @current_menu.language.iso_639_1
					return @current_menu
				end

				Odania::Menu.new(language_id: current_site.default_language.id)
			end

			# Thanks to https://github.com/mbleigh/acts-as-taggable-on
			def tag_cloud(tags, classes)
				return [] if tags.empty?

				max_count = tags.sort_by(&:count).last.count.to_f

				tags.each do |tag|
					index = ((tag.count / max_count) * (classes.size - 1))
					yield tag, classes[index.nan? ? 0 : index.round]
				end
			end
		end
	end
end
