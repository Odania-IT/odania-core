json.contents @contents, partial: 'admin/api/contents/show', as: :content
json.static_pages @static_pages, partial: 'admin/api/static_pages/show', as: :static_page
json.menu_items @menu_items, partial: 'admin/api/menu_items/show', as: :menu_item
