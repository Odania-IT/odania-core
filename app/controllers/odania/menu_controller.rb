class Odania::MenuController < ApplicationController
	before_filter :valid_site!

	def index
		accepted_langs = current_site.menus.map { |o| o.language.iso_639_1 }
		locale = http_accept_language.preferred_language_from(accepted_langs)
		language = Odania::Language.where(iso_639_1: locale).first if locale.nil?
		language = current_site.default_language if language.nil?
		menu = current_site.menus.where(language_id: language.id).first
		redirect_to menu.get_target_path
	end

	def menu_index
		menu_item = current_menu.default_menu_item unless current_menu.default_menu_item.nil?
		menu_item = current_menu.menu_items.where(parent_id: nil).first if menu_item.nil?

		return redirect_to menu_item.target_data['url'] if 'URL'.eql? menu_item.target_type
		redirect_to menu_item.get_target_path
	end

	def show_page
		# Try to find the correct menu_item
		menu_item = current_menu.menu_items.where(full_path: params[:path]).first

		# Try to find out if we have a subpart
		if menu_item.nil?
			path_exception_last_part = params[:path].gsub(/\/[a-z0-9-]*$/i, '')
			last_part_of_path = params[:path].gsub(path_exception_last_part, '')
			last_part_of_path = last_part_of_path[1, last_part_of_path.length]
			menu_item = current_menu.menu_items.where(full_path: path_exception_last_part).first
		end

		display_menu_item(menu_item, last_part_of_path)
	end

	def not_found
		render action: 'not_found', status: :not_found
	end

	def error(err_msg=nil)
		@error_msg = err_msg
		render action: 'error', status: :bad_request
	end

	private

	def display_menu_item(menu_item, last_part_of_path=nil)
		return not_found if menu_item.nil?
		data = Odania::TargetType.get_target(menu_item, current_site, last_part_of_path)

		return not_found if data.nil?
		return error(data[:error]) if data[:error]

		unless data[:render_partial].nil?
			@current_menu_item = menu_item
			@render_partial = data
			render action: 'show_page'
			return
		end
		return redirect_to data[:redirect] unless data[:redirect].nil?

		not_found
	end
end
