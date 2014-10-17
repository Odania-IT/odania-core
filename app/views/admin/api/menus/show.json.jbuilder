json.menu do
	json.partial! partial: 'admin/api/menus/show', locals: {menu: @menu}
end

json.data do
	json.widgets @widgets, partial: 'admin/api/widgets/show', as: :widget
end
