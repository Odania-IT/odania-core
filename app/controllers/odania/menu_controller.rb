class Odania::MenuController < ApplicationController
	before_action :valid_site!
	before_action :valid_menu!, except: [:index]

	def index
		accepted_langs = current_site.menus.map { |o| o.language.iso_639_1 }
		locale = http_accept_language.preferred_language_from(accepted_langs)
		language = Odania::Language.where(iso_639_1: locale).first if locale.nil?
		language = current_site.default_language if language.nil?
		menu = current_site.menus.where(language_id: language.id).first

		return render_not_found if menu.nil?
		redirect_to menu.get_target_path
	end

	def menu_index
		menu_item = current_menu.default_menu_item unless current_menu.default_menu_item_id.nil?
		menu_item = current_menu.menu_items.where(parent_id: nil).first if menu_item.nil?

		return render_error(t('No content defined')) if menu_item.nil?

		return redirect_to menu_item.target_data['url'] if 'URL'.eql? menu_item.target_type
		redirect_to menu_item.get_target_path
	end

	def show_page
		# Try to find the correct menu_item
		menu_item = current_menu.menu_items.where(full_path: params[:path]).first
		display_menu_item(menu_item)
	end

	private

	def display_menu_item(menu_item)
		return render_not_found if menu_item.nil?
		data = Odania::TargetType.get_target(menu_item)

		return render_not_found if data.nil?
		return render_error(data[:error]) if data[:error]

		unless data[:render_partial].nil?
			@current_menu_item = menu_item
			@render_partial = data
			render action: 'show_page'
			return
		end
		return redirect_to data[:redirect] unless data[:redirect].nil?

		render_not_found
	end
end
