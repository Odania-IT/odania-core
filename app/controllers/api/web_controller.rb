class Api::WebController < ApiController
	def index
		@results = $elasticsearch_client.search index: 'odania', type: 'layout', body: {}
	end

	def show
	end

	def create
		data = params[:data]
		$elasticsearch_client.index index: 'odania', type: 'layout', body: data
	end

	def update
	end
end
