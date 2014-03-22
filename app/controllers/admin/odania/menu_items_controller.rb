class Admin::Odania::MenuItemsController < AdminController
	before_filter :set_odania_menu, except: [:select_odania_menu]
	before_action :set_odania_menu_item, only: [:show, :edit, :update, :destroy, :set_default]

	# GET /odania/menu_items
	def index
		@odania_menu_items = @odania_menu.menu_items.order('parent_id ASC')
	end

	# GET /odania/menu_items/1
	def show
	end

	# GET /odania/menu_items/new
	def new
		@odania_menu_item = Odania::MenuItem.new
		@odania_menu_item.target_type = Odania::TargetType.targets.keys.first
	end

	# GET /odania/menu_items/1/edit
	def edit
	end

	# POST /odania/menu_items
	def create
		@odania_menu_item = Odania::MenuItem.new(odania_menu_item_params)
		@odania_menu_item.target_data = odania_target_data_params
		@odania_menu_item.menu_id = @odania_menu.id

		if @odania_menu_item.save
			redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu), notice: 'Menu item was successfully created.'
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /odania/menu_items/1
	def update
		@odania_menu_item.target_data = odania_target_data_params
		if @odania_menu_item.update(odania_menu_item_params)
			redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu), notice: 'Menu item was successfully updated.'
		else
			render action: 'edit'
		end
	end

	# DELETE /odania/menu_items/1
	def destroy
		@odania_menu_item.destroy
		@odania_menu.save
		redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu), notice: 'Menu item was successfully destroyed.'
	end

	def set_default
		@odania_menu.default_menu_item_id = @odania_menu_item.id
		@odania_menu.save!

		redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu), notice: 'Menu item set to default.'
	end

	def overview
		menu = Odania::Menu.first
		redirect_to admin_odania_menu_path, notice: 'Create a menu first' if menu.nil?

		redirect_to admin_odania_menu_odania_menu_items_path(menu_id: menu.id.to_s)
	end

	def select_odania_menu
		if params[:menu]
			if params[:menu][:id]
				@odania_menu = Odania::Menu.where(id: params[:menu][:id]).first
				return redirect_to admin_odania_menu_odania_menu_items_path(menu_id: @odania_menu.id.to_s) unless @odania_menu.nil?
			end
		end

		@odania_menu = Odania::Menu.where(id: params[:odania_menu]).first
		@odania_menu = Odania::Menu.first if @odania_menu.nil?
		redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu.id.to_s) unless @odania_menu.nil?
		redirect_to admin_odania_menus_path
	end

	private
	# Set the odania menu that is currently edited
	def set_odania_menu
		@odania_menu = Odania::Menu.where(id: params[:menu_id]).first
		@odania_menu = Odania::Menu.first if @odania_menu.nil?
		redirect_to admin_odania_menus_path if @odania_menu.nil?
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_odania_menu_item
		@odania_menu_item = @odania_menu.menu_items.where(id: params[:id]).first
		redirect_to admin_odania_menu_odania_menu_items_path(@odania_menu) if @odania_menu_item.nil?
	end

	# Only allow a trusted parameter "white list" through.
	def odania_menu_item_params
		params.require(:odania_menu_item).permit(:title, :published, :target_type, :parent_id)
	end

	# Parameter for target data
	def odania_target_data_params
		params.require(:target_data)
	end
end
