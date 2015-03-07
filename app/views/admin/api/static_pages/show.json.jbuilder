json.static_page do
	json.partial! partial: 'admin/api/static_pages/show', locals: {static_page: @static_page}
end

json.data do
	json.widgets @widgets, partial: 'admin/api/widgets/show', as: :widget
end
