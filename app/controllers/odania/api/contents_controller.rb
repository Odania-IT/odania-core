class Odania::Api::ContentsController < Odania::ApiController
	def index
		@contents = Odania::Content.where(site_id: params[:site_id], language_id: params[:language_id]).active.order('created_at DESC')
	end

	def show
		@content = Odania::Content.where(site_id: params[:site_id], language_id: params[:language_id], id: params[:id]).active.first
		bad_api_request('resource_not_found') if @content.nil?
	end
end
