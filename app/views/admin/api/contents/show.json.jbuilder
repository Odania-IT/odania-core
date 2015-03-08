json.content do
	json.partial! partial: 'admin/api/contents/show', locals: {content: @content}
end

json.data do
	json.widgets @widgets, partial: 'admin/api/widgets/show', as: :widget
	json.categories @categories, partial: 'admin/api/categories/show', as: :category
end
