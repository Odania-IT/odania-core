class Api::WebController < ApiController
	include EntryConcern

	def index
		search 'web'
	end

	def show
		get_entry 'web', params[:id]
		render status: :not_found, text: 'Not found' if @entry.nil?
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
