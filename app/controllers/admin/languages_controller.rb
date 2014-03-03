class Admin::LanguagesController < ApplicationController
	before_action :set_admin_language, only: [:show, :edit, :update, :destroy]

	# GET /admin/languages
	def index
		@admin_languages = Odania::Language.all
	end

	# GET /admin/languages/1
	def show
	end

	# GET /admin/languages/new
	def new
		@admin_language = Odania::Language.new
	end

	# GET /admin/languages/1/edit
	def edit
	end

	# POST /admin/languages
	def create
		@admin_language = Odania::Language.new(admin_language_params)

		if @admin_language.save
			redirect_to admin_languages_path, notice: 'Language was successfully created.'
		else
			render action: 'new'
		end
	end

	# PATCH/PUT /admin/languages/1
	def update
		if @admin_language.update(admin_language_params)
			redirect_to admin_languages_path, notice: 'Language was successfully updated.'
		else
			render action: 'edit'
		end
	end

	# DELETE /admin/languages/1
	def destroy
		@admin_language.destroy
		redirect_to admin_languages_url, notice: 'Language was successfully destroyed.'
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_admin_language
		@admin_language = Odania::Language.where(_id: params[:id]).first
		redirect_to admin_languages_path if @admin_language.nil?
	end

	# Only allow a trusted parameter "white list" through.
	def admin_language_params
		params.require(:admin_language).permit(:name, :iso_639_1)
	end
end
