class Protected::ApiController < Odania::ApiController
	before_action :verify_api_user
end
