class Odania::WelcomeController < ApplicationController
	before_filter :valid_site!

	def index
		menu_item = current_site.get_current_menu(current_site.language).menu_items.where(is_default_page: true).first
		return redirect_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data) unless menu_item.nil?

		menu_item = current_site.get_current_menu(current_site.language).menu_items.where(parent_id: nil).first
		return redirect_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data) unless menu_item.nil?
	end
end
