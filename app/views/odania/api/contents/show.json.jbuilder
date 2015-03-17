json.content do
	json.partial! partial: 'odania/api/contents/show', locals: {content: @content}
end

json.data do
	json.widgets @widgets, partial: 'odania/api/widgets/show', as: :widget
	json.categories @categories, partial: 'odania/api/categories/show', as: :category
end
