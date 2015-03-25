class Odania::Api::SitesController < Odania::ApiController
	def index
		@sites = Odania::Site.active.order('domain ASC, subdomain ASC')
	end

	def show
		@site = Odania::Site.where(id: params[:id].to_i).first
		bad_api_request('resource_not_found') if @site.nil?
	end
end
