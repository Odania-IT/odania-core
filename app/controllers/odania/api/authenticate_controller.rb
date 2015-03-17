class Odania::Api::AuthenticateController < Odania::ApiController
	# Token auth (already registered)
	def token
		device_info = params[:device]
		token = params[:token]

		@device = Odania::UserDevice.where(token: token, uuid: device_info['uuid']).first
		return bad_api_request('invalid_token') if @device.nil?
		@user = @device.user
	end
end
