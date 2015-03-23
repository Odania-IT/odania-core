class Protected::ApiController < Odania::ApiController
	before_action :authenticate_user!
end
