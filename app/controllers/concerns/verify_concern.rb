module VerifyConcern
	extend ActiveSupport::Concern

	def verify_site_and_menu
		@site = Odania::Site.where(id: params[:site_id]).first
		bad_api_request('resource_not_found') if @site.nil?

		@menu = Odania::Menu.where(site_id: @site.id, id: params[:menu_id]).first
		bad_api_request('resource_not_found') if @menu.nil?
	end
end
