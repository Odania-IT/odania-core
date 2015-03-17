json.static_page do
	json.partial! partial: 'odania/api/static_pages/show', locals: {static_page: @static_page}
end

json.data do
	json.widgets @widgets, partial: 'odania/api/widgets/show', as: :widget
end
