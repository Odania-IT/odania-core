json.admin do
	json.pages Odania::Admin.pages
	json.templates Odania::Admin.templates
	json.widgets Odania.widgets
	json.targets Odania::TargetType.targets
	json.language_id current_user.language_id.nil? ? @languages.first.id : current_user.language_id
	json.plugins Odania::Protected.plugins
end

json.sites @sites, partial: 'admin/api/sites/show', as: :site
json.languages @languages, partial: 'api/languages/show', as: :language

json.general do
	json.templates Odania.templates
	json.content_states Odania::Content.states.keys
end
