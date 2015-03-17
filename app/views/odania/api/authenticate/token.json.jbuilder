json.user do
	json.partial! partial: 'odania/api/users/show', locals: {user: @user}
end
json.token @device.token
