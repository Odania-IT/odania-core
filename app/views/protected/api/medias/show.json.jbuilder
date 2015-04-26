json.media do
	json.partial! partial: 'odania/api/medias/show', locals: {media: @media}
end
