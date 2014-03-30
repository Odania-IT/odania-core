class Odania::TagsController < ApplicationController
	def index
		@odania_tags = current_site.tag_counts_on(:tags)
	end

	def show
		@tag = current_site.tags.where(name: params[:tag]).first
		return render action: 'not_found', status: :not_found if @tag.nil?

		@tag_xrefs = @tag.tag_xrefs
		render action: 'not_found', status: :not_found if @tag_xrefs.empty?
	end
end
