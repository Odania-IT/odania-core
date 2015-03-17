json.user do
	unless @user.nil?
		json.partial! partial: 'api/users/show', locals: {user: @user}
		json.token @device.token unless @device.nil?
	end
end