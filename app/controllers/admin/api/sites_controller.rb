class Admin::Api::SitesController < Admin::ApiController
	before_action :verify_site, except: [:index, :create]

	def index
		@sites = Odania::Site.order('domain ASC, subdomain ASC')
	end

	def show
		@widgets = Odania::Widget.where(site_id: @site.id)
		@static_pages = Odania::StaticPage.where('site_id = ? OR (is_global = ? AND language_id = ?)', @site.id, true, @site.default_language_id)
	end

	def create
		@site = Odania::Site.new(site_params)
		@site.is_default = true if Odania::Site.where(is_default: true).count == 0
		@site.additional_parameters = params[:site][:additional_parameters]

		if @site.save
			update_languages

			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @site.errors}, status: :bad_request
		end
	end

	def update
		@site.additional_parameters = params[:site][:additional_parameters]
		if @site.update(site_params)
			update_languages

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
		params.require(:site).permit(:name, :title, :domain, :subdomain, :is_active, :is_default, :tracking_code, :description, :user_signup_allowed,
														:default_from_email, :notify_email_address, :imprint_id, :terms_and_conditions_id,
														:default_widget_id, :redirect_to_id, :template, :default_language_id, social: [:linked_in, :facebook, :google_plus, :twitter],
														meta: [:keywords])
	end

	def update_languages
		menus = []
		default_language_exists = false
		unless params[:site][:languages].nil?
			params[:site][:languages].each do |language_id|
				menu = @site.menus.where(language_id: language_id).first
				menu = @site.menus.create(language_id: language_id) if menu.nil?
				menus << menu.id

				default_language_exists = true if language_id.eql? @site.default_language_id
			end
		end

		unless default_language_exists
			menu = @site.menus.create(language_id: @site.default_language_id)
			menus << menu
		end

		@site.menus.where('id NOT IN (?)', menus).destroy_all
	end
end
