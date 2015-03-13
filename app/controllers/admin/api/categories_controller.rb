class Admin::Api::CategoriesController < Admin::ApiController
	include VerifyConcern

	before_action :verify_site_and_menu
	before_action :verify_category, except: [:index, :create]
	
	def index
		@categories = Odania::Category.where(site_id: params[:site_id], language_id: @menu.language_id).order('title ASC')
	end

	def show
		@widgets = Odania::Widget.where(site_id: @site.id, language_id: @menu.language_id)
		@categories = Odania::Category.where(site_id: @site.id, language_id: @menu.language_id)
	end

	def create
		@category = Odania::Category.new(category_params)
		@category.user_id = current_user.id
		@category.site_id = @site.id
		@category.language_id = @menu.language_id

		if @category.save
			flash[:notice] = t('created')

			index
			render action: :index
		else
			render json: {errors: @category.errors}, status: :bad_request
		end
	end

	def update
		if @category.update(category_params)
			flash[:notice] = t('updated')

			index
			render action: :index
		else
			render json: {errors: @category.errors}, status: :bad_request
		end
	end

	def destroy
		@category.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_category
		@category = Odania::Category.where(site_id: params[:site_id], language_id: @menu.language_id, id: params[:id]).first
		bad_api_request('resource_not_found') if @category.nil?
	end

	def category_params
		params.require(:category).permit(:title, :parent_id)
	end
end
