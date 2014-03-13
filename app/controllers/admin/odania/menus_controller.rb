class Admin::Odania::MenusController < AdminController
	before_action :set_admin_menu, only: [:show, :edit, :update, :destroy]

	# GET /admin/menus
	def index
		@admin_menus = @admin_site.menus.order('title ASC')
	end

	# GET /admin/menus/1
	def show
	end

	# GET /admin/menus/new
	def new
		@admin_menu = Odania::Menu.new
		@admin_menu.site_id = @admin_site.id
		@admin_menu.language_id = @admin_site.default_language_id
	end

	# GET /admin/menus/1/edit
	def edit
	end

	# POST /admin/menus
	def create
		@admin_menu = Odania::Menu.new(admin_menu_params)

		if @admin_menu.save
			redirect_to admin_odania_menus_path, notice: 'Menu was successfully created.'
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /admin/menus/1
	def update
		if @admin_menu.update(admin_menu_params)
			redirect_to admin_odania_menus_path, notice: 'Menu was successfully updated.'
		else
			render action: 'edit'
		end
	end

	# DELETE /admin/menus/1
	def destroy
		@admin_menu.destroy
		redirect_to admin_odania_menus_path, notice: 'Menu was successfully destroyed.'
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_admin_menu
		@admin_menu = Odania::Menu.where(id: params[:id]).first
		redirect_to admin_odania_menus_path if @admin_menu.nil?
	end

	# Only allow a trusted parameter "white list" through.
	def admin_menu_params
		params.require(:odania_menu).permit(:title, :published, :is_default_menu, :menu_type, :site_id, :language_id)
	end
end
