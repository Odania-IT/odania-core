class Odania::CategoriesController < ApplicationController
	before_filter :valid_site!

	def index
		@categories = Odania::Category.where(site_id: current_site.id, language_id: current_menu.language_id).order('title ASC')
	end

	def show
		@category = current_site.categories.where(id: params[:id]).first
		return render_not_found if @category.nil?

		@category_xrefs = @category.category_xrefs
	end
end
