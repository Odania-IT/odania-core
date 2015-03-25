class Odania::Api::StaticPagesController < Odania::ApiController
	def index
		@static_pages = Odania::StaticPage.where('(site_id = ? OR is_global = ?) AND language_id = ?', params[:site_id], true, params[:language_id]).order('created_at DESC')
	end

	def show
		@static_page = Odania::StaticPage.where('id = ? AND (site_id = ? OR is_global = ?) AND language_id = ?', params[:id].to_i, params[:site_id], true, params[:language_id]).first
		return bad_api_request('resource_not_found') if @static_page.nil?
	end
end
