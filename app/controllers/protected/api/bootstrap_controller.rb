class Protected::Api::BootstrapController < Protected::ApiController
	def index
	end

	def change_language
		change_user_language
	end
end
