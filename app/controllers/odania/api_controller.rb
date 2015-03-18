class Odania::ApiController < ApplicationController
	after_action :add_flash_to_header

	# @TODO maybe we can add it as header?
	skip_before_action :verify_authenticity_token

	private

	def add_flash_to_header
		# add different flashes to header
		response.headers['X-Flash-Error'] = flash[:error] unless flash[:error].blank?
		response.headers['X-Flash-Warning'] = flash[:warning] unless flash[:warning].blank?
		response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
		response.headers['X-Flash-Message'] = flash[:message] unless flash[:message].blank?

		# make sure flash does not appear on the next page
		flash.discard
	end

	def bad_api_request(msg)
		render json: {message: msg}, status: :bad_request
	end

	def verify_api_user
		@current_device = Odania::UserDevice.where(token: request.headers['X-API-KEY']).first
		return render json: {error: 'unauthorized'}, status: :unauthorized if @current_device.nil?

		@current_user = @current_device.user
	end

	def validate_own_resource
		render json: {error: 'unauthorized'}, status: :unauthorized unless @current_user.id.eql? params[:user_id].to_i
	end
end
