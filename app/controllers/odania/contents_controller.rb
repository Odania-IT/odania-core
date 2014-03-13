class Odania::ContentsController < ApplicationController
	before_filter :valid_site!

	# GET /odania/contents
	def index
		@odania_contents = current_site.contents
	end

	# GET /odania/contents/1
	def show
		@odania_content = current_site.contents.where(id: params[:id].to_i).first
		return not_found if @odania_content.nil?
	end
end
