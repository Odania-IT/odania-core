class Admin::Api::MenuItemsController < Admin::ApiController
	before_action :verify_menu_item, except: [:index, :create, :initial_data]
	before_action :verify_menu, only: [:index, :initial_data]

	def index
		@menu_items = Odania::MenuItem.where(menu_id: params[:menu_id]).order('title ASC')
	end

	def show
	end

	def create
		@menu = Odania::Menu.where(site_id: params[:site_id], id: params[:menu_id]).first
		bad_api_request('invalid_menu') if @menu.nil?

		@menu_item = Odania::MenuItem.new(content_params)
		@menu_item.target_data = odania_target_data_params
		@menu_item.menu_id = @menu.id

		if @menu_item.save
			if @menu.default_menu_item_id.nil? and @menu_item.published
				@menu.default_menu_item_id = @menu_item.id
				@menu.save
			end

			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @menu_item.errors}, status: :bad_request
		end
	end

	def update
		@menu_item.target_data = odania_target_data_params
		if @menu_item.update(content_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @menu_item.errors}, status: :bad_request
		end
	end

	def destroy
		@menu_item.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	def initial_data
		@menu_items = Odania::MenuItem.where(menu_id: @menu.id)
		@menu_items = @menu_items.where('id != ?', params[:menu_item_id]) unless params[:menu_item_id].nil?
		@static_pages = Odania::StaticPage.where(site_id: @menu.site_id, language_id: @menu.language_id)
		@contents = Odania::Content.where(site_id: @menu.site_id, language_id: @menu.language_id)
	end

	def set_default
		@menu.default_menu_item_id = @menu_item.id
		@menu.save!

		@menu_items = Odania::MenuItem.where(menu_id: @menu.id).order('title ASC')
		render action: :index
	end

	private

	def verify_menu
		@menu = Odania::Menu.where(id: params[:menu_id], site_id: params[:site_id]).first
		return bad_api_request('resource_not_found') if @menu.nil?
	end

	def verify_menu_item
		@menu_item = Odania::MenuItem.where(menu_id: params[:menu_id], id: params[:id]).first
		return bad_api_request('resource_not_found') if @menu_item.nil?
		@menu = @menu_item.menu
		return bad_api_request('resource_not_found') unless @menu.site_id.eql? params[:site_id].to_i
	end

	def content_params
		params.require(:menu_item).permit(:title, :published, :target_type, :parent_id, :position)
	end

	# Parameter for target data
	def odania_target_data_params
		params[:target_data].nil? ? {} : params[:target_data]
	end
end
