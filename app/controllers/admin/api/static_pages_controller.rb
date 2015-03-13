class Admin::Api::StaticPagesController < Admin::ApiController
	include VerifyConcern

	before_action :verify_site_and_menu
	before_action :verify_content, except: [:index, :create]
	
	def index
		@static_pages = Odania::StaticPage.where('(site_id = ? OR is_global = ?) AND language_id = ?', params[:site_id], true, @menu.language_id).order('created_at DESC')
	end

	def show
		@widgets = Odania::Widget.where(site_id: @site.id)
	end

	def create
		@static_page = Odania::StaticPage.new(static_page_params)
		@static_page.user_id = current_user.id
		@static_page.site_id = @site.id

		if @static_page.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @static_page.errors}, status: :bad_request
		end
	end

	def update
		if @static_page.update(static_page_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @static_page.errors}, status: :bad_request
		end
	end

	def destroy
		@static_page.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_content
		@static_page = Odania::StaticPage.where('id = ? AND (site_id = ? OR is_global = ?) AND language_id = ?', params[:id], params[:site_id], true, @menu.language_id).first
		bad_api_request('resource_not_found') if @static_page.nil?
	end

	def static_page_params
		params.require(:static_page).permit(:title, :body, :language_id, :widget_id, :is_global)
	end
end
