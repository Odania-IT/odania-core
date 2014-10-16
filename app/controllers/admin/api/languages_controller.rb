class Admin::Api::LanguagesController < Admin::ApiController
	before_action :verify_language, except: [:index, :create]
	
	def index
		@languages = Odania::Language.order('iso_639_1 ASC')
	end

	def show
	end

	def create
		@language = Odania::Language.new(language_params)

		if @language.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @language.errors}, status: :bad_request
		end
	end

	def update
		if @language.update(language_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @language.errors}, status: :bad_request
		end
	end

	def destroy
		@language.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_language
		@language = Odania::Language.where(id: params[:id]).first
		bad_api_request('resource_not_found') if @language.nil?
	end

	def language_params
		params.require(:language).permit(:name, :iso_639_1)
	end
end
