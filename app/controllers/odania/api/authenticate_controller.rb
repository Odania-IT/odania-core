class Odania::Api::AuthenticateController < Odania::ApiController
	# Token auth (already registered)
	def token
		device_info = params[:device]
		token = params[:token]

		@device = Odania::UserDevice.where(token: token, uuid: device_info['uuid']).first
		return bad_api_request('invalid_token') if @device.nil?
		@user = @device.user
	end

	def development
		device_info = params[:device].nil? ? 'development-uuid' : params[:device]
		return bad_api_request('unauthorized'), status: :unauthorized unless 'development'.eql? Rails.env

		Odania::UserDevice.transaction do
			@device = Odania::UserDevice.where(uuid: device_info['uuid'], platform: device_info['platform']).first
			if @device.nil?
				Odania::UserDevice.transaction do
					@device = Odania::UserDevice.new(uuid: device_info['uuid'], platform: device_info['platform'], model: device_info['model'], version: device_info['version'])
					user = Odania::User.where(name: 'Developer', email: 'developer@example.com').first
					user = Odania::User.create(name: 'Developer', email: 'developer@example.com') if user.nil?
					@device.user_id = user.id
					@device.save!
				end
			end
		end

		@user = @device.user

		render action: :token
	end

	def facebook

		render action: :token
	end
end
