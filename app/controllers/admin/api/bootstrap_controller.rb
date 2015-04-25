class Admin::Api::BootstrapController < Admin::ApiController
	def index
		@sites = Odania::Site.order('name ASC')
		@languages = Odania::Language.order('iso_639_1 ASC')
	end

	def change_language
		change_user_language
	end
end
