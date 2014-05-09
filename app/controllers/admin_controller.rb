class AdminController < ApplicationController
	before_action :authenticate_user!, :choose_site, :require_admin_role!
	skip_before_filter :valid_site!
	layout :set_admin_layout

	def set_admin_layout
		current_user.admin_layout || Odania.admin.templates.keys.first || 'odania_core/admin'
	end

	def choose_site
		site_id = params[:site].nil? ? nil : params[:site][:id]
		@admin_site = Odania::Site.where(id: site_id).first unless site_id.nil?
		@admin_site = Odania::Site.where(id: session[:site_id]).first if @admin_site.nil? and !session[:site_id].nil?
		@admin_site = Odania::Site.first if @admin_site.nil?
		session[:site_id] = @admin_site.id.to_s unless @admin_site.nil?

		set_odania_menu unless @admin_site.nil?
	end

	# Set the odania menu that is currently edited
	def set_odania_menu
		@odania_menu = @admin_site.menus.where(id: params[:menu_id]).first
		@odania_menu = @admin_site.menus.where(id: session[:menu_id]).first if @odania_menu.nil?
		@odania_menu = @admin_site.menus.first if @odania_menu.nil?
		@odania_menu = Odania::Menu.first if @odania_menu.nil?
		session[:menu_id] = @odania_menu.id unless @odania_menu.nil?
	end
end
