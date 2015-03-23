class Admin::Api::ContentsController < Admin::ApiController
	include VerifyConcern

	before_action :verify_site_and_menu
	before_action :verify_content, except: [:index, :create]
	
	def index
		@contents = Odania::Content.where(site_id: params[:site_id], language_id: @menu.language_id).order('created_at DESC')
	end

	def show
		@widgets = Odania::Widget.where('(site_id = ? OR is_global = ?) AND language_id = ?', @site.id, true, @menu.language_id)
		@categories = Odania::Category.where(site_id: @site.id, language_id: @menu.language_id)
	end

	def create
		@content = Odania::Content.new(content_params)
		@content.user_id = current_user.id
		@content.site_id = @site.id

		if @content.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @content.errors}, status: :bad_request
		end
	end

	def update
		if @content.update(content_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @content.errors}, status: :bad_request
		end
	end

	def destroy
		@content.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_content
		@content = Odania::Content.where(site_id: params[:site_id], language_id: @menu.language_id, id: params[:id]).first
		bad_api_request('resource_not_found') if @content.nil?
	end

	def content_params
		params.require(:content).permit(:title, :body, :body_short, :published_at, :language_id, :widget_id, :state, :category_list, :tag_list)
	end
end
