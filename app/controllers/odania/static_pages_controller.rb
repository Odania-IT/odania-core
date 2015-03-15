class Odania::StaticPagesController < ApplicationController
	def show
		@static_page = current_site.static_pages.where(id: params[:id]).first
		return render_not_found if @static_page.nil?
	end
end
