class Admin::Api::MenusController < Admin::ApiController
	before_action :verify_menu, except: [:index, :create]
	before_action :verify_site, only: [:create]

	def index
		@menus = Odania::Menu.where(site_id: params[:site_id]).order('created_at DESC')
	end

	def show
		@widgets = Odania::Widget.where(site_id: @menu.site_id, language_id: @menu.language_id)
	end

	def create
		@menu = Odania::Menu.new(content_params)
		@menu.site_id = @site.id

		if @menu.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @menu.errors}, status: :bad_request
		end
	end

	def update
		if @menu.update(content_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @menu.errors}, status: :bad_request
		end
	end

	def destroy
		@menu.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_menu
		@menu = Odania::Menu.where(site_id: params[:site_id], id: params[:id]).first
		bad_api_request('resource_not_found') if @menu.nil?
	end

	def verify_site
		@site = Odania::Site.where(id: params[:site_id]).first
		bad_api_request('resource_not_found') if @site.nil?
	end

	def content_params
		params.require(:menu).permit(:published, :is_default_menu, :menu_type, :language_id, :widget_id)
	end
end
