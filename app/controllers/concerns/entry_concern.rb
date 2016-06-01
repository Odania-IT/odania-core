module EntryConcern
	extend ActiveSupport::Concern

	def search(type)
		@entries = $elasticsearch.search index: 'odania', type: type, body: {}
	end

	def get_entry(type, id)
		@entry = $elasticsearch.search index: 'odania', type: type, id: id
	end

	def save_entry(type, id, data)
		$elasticsearch.index index: 'odania', type: type, id: id, body: data
	end

	def destroy_entry(type, id)
		$elasticsearch.delete index: 'odania', type: type, id: id
	end
end
