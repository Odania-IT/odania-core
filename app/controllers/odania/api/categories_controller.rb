class Odania::Api::CategoriesController < Odania::ApiController
	def index
		@categories = Odania::Category.where(site_id: params[:site_id], language_id: params[:language_id]).order('title ASC')
	end

	def show
		@category = Odania::Category.where(site_id: params[:site_id], language_id: params[:language_id], id: params[:id]).first
		return bad_api_request('resource_not_found') if @category.nil?
	end
end
