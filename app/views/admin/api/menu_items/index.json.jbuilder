json.menu_items @menu_items, partial: 'admin/api/menu_items/show', as: :menu_item
json.menu do
	json.partial! partial: 'admin/api/menus/show', locals: {menu: @menu}
end
