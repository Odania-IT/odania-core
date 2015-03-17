json.site do
	json.partial! partial: 'admin/api/sites/show', locals: {site: @site}
end

json.data do
	json.widgets @widgets, partial: 'admin/api/widgets/show', as: :widget
	json.static_pages @static_pages, partial: 'admin/api/static_pages/show', as: :static_page
end
