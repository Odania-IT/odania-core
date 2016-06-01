class Api::LayoutsController < ApiController
	include EntryConcern

	def index
		search 'layout'
	end

	def show
		get_entry 'layout', params[:id]
	end

	def create
		data = params[:data]
		save_entry 'layout', params[:id], data

		render json: {status: :ok}
	end

	def destroy
		destroy_entry 'layout', params[:id]

		render json: {status: :ok}
	end
end
