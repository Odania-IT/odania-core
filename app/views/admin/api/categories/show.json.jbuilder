json.category do
	json.partial! partial: 'admin/api/categories/show', locals: {category: @category}
end
