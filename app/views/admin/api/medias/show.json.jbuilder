json.media do
	json.partial! partial: 'admin/api/medias/show', locals: {media: @media}
end
