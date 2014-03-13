class Odania::WelcomeController < ApplicationController
	before_filter :valid_site!

	def index
		menu_item = current_menu.default_menu_item unless current_menu.default_menu_item.nil?
		return redirect_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data) unless menu_item.nil?

		menu_item = current_menu.menu_items.where(parent_id: nil).first
		return redirect_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data) unless menu_item.nil?
	end
end
