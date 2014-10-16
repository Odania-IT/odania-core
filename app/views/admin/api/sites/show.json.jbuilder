json.site do
	json.partial! partial: 'admin/api/sites/show', locals: {site: @site}
end

json.data do
	json.widgets @widgets, partial: 'admin/api/widgets/show', as: :widget
end
