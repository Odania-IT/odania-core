class Admin::Odania::SitesController < ApplicationController
	before_action :set_admin_site, only: [:show, :edit, :update, :destroy]

	# GET /admin/sites
	def index
		@admin_sites = Odania::Site.all
	end

	# GET /admin/sites/1
	def show
	end

	# GET /admin/sites/new
	def new
		@admin_site = Odania::Site.new
	end

	# GET /admin/sites/1/edit
	def edit
	end

	# POST /admin/sites
	def create
		@admin_site = Odania::Site.new(admin_site_params)

		if @admin_site.save
			redirect_to admin_odania_sites_path, notice: 'Site was successfully created.'
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /admin/sites/1
	def update
		if @admin_site.update(admin_site_params)
			redirect_to admin_odania_sites_path, notice: 'Site was successfully updated.'
		else
			render action: 'edit'
		end
	end

	# DELETE /admin/sites/1
	def destroy
		@admin_site.destroy
		redirect_to admin_odania_sites_path, notice: 'Site was successfully destroyed.'
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_admin_site
		@admin_site = Odania::Site.where(_id: params[:id]).first
		redirect_to admin_odania_sites_path if @admin_site.nil?
	end

	# Only allow a trusted parameter "white list" through.
	def admin_site_params
		params.require(:odania_site).permit(:name, :host, :is_active, :is_default, :tracking_code, :description, :language_id, :redirect_to_id, :template)
	end
end
