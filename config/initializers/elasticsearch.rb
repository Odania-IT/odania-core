config = YAML.load_file ERB.new(File.join(Rails.root, 'config', 'elasticsearch.yml')).result
$elasticsearch = Elasticsearch::Client.new log: true, hosts: config[Rails.env]['hosts']

$web_index = 'odania_web'
$partial_index = 'odania_partials'

# TODO add better handling for created indices
index_content = {
	cacheable: {type: 'boolean'},
	content: {type: 'string', index: 'not_analyzed'},
	domain: {type: 'string', index: 'not_analyzed'},
	full_domain: {type: 'string', index: 'not_analyzed'},
	subdomain: {type: 'string', index: 'not_analyzed'}
}

web_index_content = index_content.merge({
														 created_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
														 full_path: {type: 'string', index: 'not_analyzed'},
														 path: {type: 'string', index: 'not_analyzed'},
														 release_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
														 released: {type: 'boolean'},
														 partial_name: {type: 'string', index: 'not_analyzed'},
														 view_in_list: {type: 'boolean'}
													 })

partial_index_content = index_content.merge({
															  partial_name: {type: 'string', index: 'not_analyzed'}
														  })

begin
	$elasticsearch.indices.create index: $web_index, body: {
		mappings: {
			web: {
				properties: web_index_content
			}
		}
	}
	$elasticsearch.indices.create index: $partial_index, body: {
		mappings: {
			partial: {
				properties: partial_index_content
			}
		}
	}
rescue
	# TODO check index exists
end

$elasticsearch.indices.put_mapping index: $web_index, type: 'web', body: {
	properties: web_index_content
}

$elasticsearch.indices.put_mapping index: $partial_index, type: 'partial', body: {
	properties: partial_index_content
}
