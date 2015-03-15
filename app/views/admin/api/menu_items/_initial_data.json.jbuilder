json.contents Odania::Content.where(site_id: @menu.site_id, language_id: @menu.language_id), partial: 'admin/api/contents/show', as: :content
json.static_pages Odania::StaticPage.where(site_id: @menu.site_id, language_id: @menu.language_id), partial: 'admin/api/static_pages/show', as: :static_page
