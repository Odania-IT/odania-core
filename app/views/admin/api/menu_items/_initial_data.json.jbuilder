json.contents Odania::Content.where(site_id: @menu.site_id), partial: 'admin/api/contents/show', as: :content
