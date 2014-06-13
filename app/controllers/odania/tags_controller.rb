class Odania::TagsController < ApplicationController
	before_filter :valid_site!

	def index
		@odania_tags = current_site.tag_counts_on(:tags)
	end

	def show
		@tag = current_site.tags.where(name: params[:tag]).first
		return render_not_found if @tag.nil?

		@tag_xrefs = @tag.tag_xrefs
		return render_not_found if @tag_xrefs.empty?
	end

	def auto_complete
		term = params[:term].to_s
		result = []

		Odania::Tag.where(language_id: current_menu.language_id).where('name LIKE ?', "%#{term}%").order('count DESC').limit(10).each do |tag|
			result << {id: tag.name, label: tag.name, value: tag.name}
		end

		render json: result
	end
end
