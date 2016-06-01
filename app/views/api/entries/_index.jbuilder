json.created_at Time.now

json.hits hits do |hit|
	source = hit['_source']

	json.domain source['domain']
	json.subdomain source['subdomain']
	json.path source['path']
	json.full_path source['full_path']
	json.full_domain source['full_domain']
end
