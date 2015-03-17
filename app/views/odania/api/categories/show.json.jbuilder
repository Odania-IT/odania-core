json.category do
	json.partial! partial: 'odania/api/categories/show', locals: {category: @category}
end
