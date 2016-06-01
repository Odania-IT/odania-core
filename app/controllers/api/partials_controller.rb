class Api::PartialsController < ApiController
	include EntryConcern

	def index
		search 'partial'
	end

	def show
		get_entry 'partial', params[:id]
	end

	def create
		data = params[:data]
		save_entry 'partial', params[:id], data

		render json: {status: :ok}
	end

	def destroy
		destroy_entry 'partial', params[:id]

		render json: {status: :ok}
	end
end
