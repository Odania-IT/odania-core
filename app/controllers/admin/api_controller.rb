class Admin::ApiController < ApplicationController
	before_action :authenticate_user!, :require_admin_role!
	after_action :add_flash_to_header

	# @TODO maybe we can add it as header?
	skip_before_action :verify_authenticity_token, :valid_site!

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
end
