class Admin::Api::BootstrapController < Admin::ApiController
	def index
		@sites = Odania::Site.order('name ASC')
		@languages = Odania::Language.order('iso_639_1 ASC')
	end

	def change_language
		user = current_user
		language = Odania::Language.where(id: params[:language_id]).first
		return render json: {error: 'invalid language'}, status: :bad_request if language.nil?

		user.language_id = language.id
		user.save!

		render json: {message: 'language updated'}
	end
end
