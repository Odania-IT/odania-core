class Odania::SearchController < ApplicationController
	before_action :valid_site!

	def index
		@search_value = ''
		@contents = []
	end

	def search
		@search_value = params[:search]
		@like_search_value = "%#{@search_value}%"

		@contents = current_site.contents.active.where('title LIKE ? OR body LIKE ?', @like_search_value, @like_search_value)
		@tags = current_site.tags.where('name LIKE ?', @like_search_value)
		@categories = current_site.categories.where('title LIKE ?', @like_search_value)

		render action: :index
	end
end
