json.user do
	json.partial! partial: 'odania/api/users/show', locals: {user: @current_user}
end
