class Admin::ApiController < Odania::ApiController
	before_action :authenticate_user!, :require_admin_role!
	skip_before_filter :valid_site!
end
