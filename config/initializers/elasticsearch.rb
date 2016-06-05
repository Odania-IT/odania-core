config = YAML.load_file ERB.new(File.join(Rails.root, 'config', 'elasticsearch.yml')).result
$elasticsearch = Elasticsearch::Client.new log: true, hosts: config[Rails.env]['hosts']

# TODO add better handling for created indices
index_content = {
	cacheable: {type: 'boolean'},
	content: {type: 'string', index: 'not_analyzed'},
	created_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
	domain: {type: 'string', index: 'not_analyzed'},
	full_domain: {type: 'string', index: 'not_analyzed'},
	full_path: {type: 'string', index: 'not_analyzed'},
	path: {type: 'string', index: 'not_analyzed'},
	release_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
	released: {type: 'boolean'},
	subdomain: {type: 'string', index: 'not_analyzed'},
	view_in_list: {type: 'boolean'}
}

begin
	$elasticsearch.indices.create index: 'odania', body: {
		mappings: {
			web: {
				properties: index_content
			},
			partial: {
				properties: index_content.merge({partial_name: {type: 'string', index: 'not_analyzed'}})
			}
		}
	}
rescue
	# TODO check index exists
end

$elasticsearch.indices.put_mapping index: 'odania', type: 'web', body: {
	properties: index_content
}

$elasticsearch.indices.put_mapping index: 'odania', type: 'partial', body: {
	properties: index_content
}
