module EntryConcern
	extend ActiveSupport::Concern

	def search(type, body={})
		result = $elasticsearch.search index: 'odania', type: type, body: body
		@entries = result['hits']
	end

	def get_entry(type, id)
		begin
			result = $elasticsearch.get index: 'odania', type: type, id: id
			@entry = result['_source']
		rescue
			@entry = nil
		end
	end

	def save_entry(type, id, data)
		#strftime('%Y-%m-%d %H:%M:%S')
		data['created_at'] = Date.parse(data['created_at']).iso8601 unless data['created_at'].nil?
		data['release_at'] = Date.parse(data['release_at']).iso8601 unless data['release_at'].nil?
		$elasticsearch.index index: 'odania', type: type, id: id, body: data
	end

	def destroy_entry(type, id)
		$elasticsearch.delete index: 'odania', type: type, id: id
	end

	def build_domain_query(domain, req_host, filter)
		{
			filtered: {
				filter: filter,
				query: {
					bool: {
						should: [
							{
								bool: {
									must: [
										{match: {full_domain: {query: req_host, boost: 10}}},
										{term: {released: true}}
									]
								}
							},
							{
								bool: {
									must: [
										{match: {full_domain: {query: domain, boost: 6}}},
										{term: {released: true}}
									]
								}
							},
							{
								bool: {
									must: [
										{match: {domain: '_general'}},
										{term: {released: true}}
									]
								}
							}
						],
						minimum_should_match: 1
					}
				}
			}
		}
	end
end
