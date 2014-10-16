class Admin::Api::SitesController < Admin::ApiController
	before_action :verify_site, except: [:index, :create]

	def index
		@sites = Odania::Site.order('name ASC')
	end

	def show
	end

	def create
		@site = Odania::Site.new(site_params)

		if @site.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @site.errors}, status: :bad_request
		end
	end

	def update
		if @site.update(site_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @site.errors}, status: :bad_request
		end
	end

	def destroy
		@site.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_site
		@site = Odania::Site.where(id: params[:id]).first
		bad_api_request('resource_not_found') if @site.nil?
	end

	def site_params
		params.require(:site).permit(:name, :host, :is_active, :is_default, :tracking_code, :description, :user_signup_allowed,
														:default_from_email, :notify_email_address, :imprint, :terms_and_conditions,
														:redirect_to_id, :template, :default_language_id, :language_ids => [])
	end
end
