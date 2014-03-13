class AdminController < ApplicationController
	before_filter :authenticate_user!, :choose_site
	layout :set_admin_layout

	def set_admin_layout
		current_user.admin_layout || Odania.admin.admin_templates.keys.first || 'odania_core/admin'
	end

	def choose_site
		site_id = params[:site].nil? ? nil : params[:site][:id]
		@admin_site = Odania::Site.where(id: site_id).first unless site_id.nil?
		@admin_site = Odania::Site.where(id: session[:site_id]).first if @admin_site.nil? and !session[:site_id].nil?
		@admin_site = Odania::Site.first if @admin_site.nil?
		session[:site_id] = @admin_site.id.to_s unless @admin_site.nil?
	end
end
