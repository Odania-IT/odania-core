class Admin::Odania::ContentsController < AdminController
	before_action :set_admin_content, only: [:show, :edit, :update, :destroy]

	# GET /admin/contents
	def index
		@admin_contents = @admin_site.contents.order_by([:name, :asc])
	end

	# GET /admin/contents/1
	def show
	end

	# GET /admin/contents/new
	def new
		@admin_content = Odania::Content.new
		@admin_content.site_id = @admin_site.id
		@admin_content.language_id = @admin_site.language_id
	end

	# GET /admin/contents/1/edit
	def edit
	end

	# POST /admin/contents
	def create
		@admin_content = Odania::Content.new(admin_content_params)

		if @admin_content.save
			redirect_to admin_odania_contents_path, notice: 'Content was successfully created.'
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /admin/contents/1
	def update
		if @admin_content.update(admin_content_params)
			redirect_to admin_odania_contents_path, notice: 'Content was successfully updated.'
		else
			render action: 'edit'
		end
	end

	# DELETE /admin/contents/1
	def destroy
		@admin_content.destroy
		redirect_to admin_odania_contents_url, notice: 'Content was successfully destroyed.'
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_admin_content
		@admin_content = Odania::Content.where(_id: params[:id]).first
		redirect_to admin_odania_contents_path if @admin_content.nil?
	end

	# Only allow a trusted parameter "white list" through.
	def admin_content_params
		params.require(:odania_content).permit(:title, :body, :body_short, :published_at, :language_id, :site_id)
	end
end
