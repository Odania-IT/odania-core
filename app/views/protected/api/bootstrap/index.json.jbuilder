json.site do
	json.partial! partial: 'api/sites/show', locals: {site: current_site}
end

json.languages @languages, partial: 'api/languages/show', as: :language
json.current_time date_to_time_since_epoch(Time.now)

json.general do
	json.templates Odania.templates
	json.content_states Odania::Content.states.keys
end
