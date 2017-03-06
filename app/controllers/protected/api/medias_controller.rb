class Protected::Api::MediasController < Protected::ApiController
	include VerifyConcern

	before_action :verify_media, except: [:index, :create]
	
	def index
		@medias = Odania::Media.where(site_id: current_site.id, user_id: current_user.id).order('created_at DESC')
	end

	def show
	end

	def create
		@media = Odania::Media.new(media_params)
		@media.user_id = current_user.id
		@media.site_id = current_site.id
		@media.language_id = current_site.default_language_id if @media.language_id.nil? or @media.language_id.eql?(0)

		if @media.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @media.errors}, status: :bad_request
		end
	end

	def update
		if @media.update(media_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @media.errors}, status: :bad_request
		end
	end

	def destroy
		@media.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_media
		@media = Odania::Media.where(site_id: current_site.id, user_id: current_user.id, id: params[:id]).first
		bad_api_request('resource_not_found') if @media.nil?
	end

	def media_params
		params.require(:media).permit(:title, :language_id, :image)
	end
end
