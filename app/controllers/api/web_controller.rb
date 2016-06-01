class Api::WebController < ApiController
	include EntryConcern

	def index
		search 'web'

		logger.info @entries['hits']['hits'].inspect
		#logger.info @entries.inspect
	end

	def show
		get_entry 'web', params[:id]
	end

	def create
		data = params[:data]
		save_entry 'web', params[:id], data

		render json: {status: :ok}
	end

	def destroy
		destroy_entry 'web', params[:id]

		render json: {status: :ok}
	end
end
