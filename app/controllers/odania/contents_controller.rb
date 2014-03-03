class Odania::ContentsController < ApplicationController
	before_filter :valid_site!

	# GET /odania/contents
	def index
		@odania_contents = Odania::Content.all
	end

	# GET /odania/contents/1
	def show
		@odania_content = Odania::Content.where(_id: params[:id]).first
		return not_found if @odania_content.nil?
	end
end
