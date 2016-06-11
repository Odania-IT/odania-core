class ElasticsearchIndices
	def initialize
		index_content = {
			cacheable: {type: 'boolean'},
			content: {type: 'string', index: 'not_analyzed'},
			domain: {type: 'string', index: 'not_analyzed'},
			full_domain: {type: 'string', index: 'not_analyzed'},
			subdomain: {type: 'string', index: 'not_analyzed'}
		}

		@settings_content = {
			index: {
				analysis: {
					analyzer: {
						analyzer_keyword: {
							tokenizer: "keyword",
							filter: "lowercase"
						}
					}
				}
			}
		}

		@web_index_content = index_content.merge({
																  created_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
																  full_path: {type: 'string', index: 'not_analyzed', analyzer: 'analyzer_keyword'},
																  path: {type: 'string', index: 'not_analyzed', analyzer: 'analyzer_keyword'},
																  release_at: {type: 'date', format: 'strict_date_optional_time||epoch_millis'},
																  released: {type: 'boolean'},
																  view_in_list: {type: 'boolean'}
															  })

		@partial_index_content = index_content.merge({
																		partial_name: {type: 'string', index: 'not_analyzed', analyzer: 'analyzer_keyword'}
																	})
	end

	def create_or_update
		begin
			create
		rescue
			# TODO check index exists
		end

		begin
			update_mappings
		rescue
			# TODO check index exists
		end

		begin
			update_settings
		rescue
			# TODO check index exists
		end
	end

	def create
		$elasticsearch.indices.create index: $web_index, body: {
			settings: @settings_content,
			mappings: {
				web: {
					properties: @web_index_content
				}
			}
		}
		$elasticsearch.indices.create index: $partial_index, body: {
			settings: @settings_content,
			mappings: {
				partial: {
					properties: @partial_index_content
				}
			}
		}
	end

	def update_settings
		$elasticsearch.indices.put_settings index: $web_index, body: {
			settings: @settings_content
		}

		$elasticsearch.indices.put_settings index: $partial_index, body: {
			settings: @settings_content
		}
	end

	def update_mappings
		$elasticsearch.indices.put_mapping index: $web_index, type: 'web', body: {
			properties: @web_index_content
		}

		$elasticsearch.indices.put_mapping index: $partial_index, type: 'partial', body: {
			properties: @partial_index_content
		}
	end
end
