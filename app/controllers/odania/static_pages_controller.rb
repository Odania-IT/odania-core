class Odania::StaticPagesController < ApplicationController
	before_action :valid_site!

	def show
		@static_page = current_site.static_pages.where(id: params[:id]).first
		return render_not_found if @static_page.nil?
	end
end
