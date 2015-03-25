class Odania::ContentsController < ApplicationController
	before_action :valid_site!

	def index
		@odania_contents = current_site.contents.active

		unless params[:tag].nil?
			odania_tag = Odania::Tag.where(name: params[:tag], language_id: current_menu.language_id).first
			@odania_contents = @odania_contents.joins(:tags).where(odania_tag_xrefs: {tag_id: odania_tag.id}) unless odania_tag.nil?
		end

		@odania_contents = @odania_contents.where(language_id: current_menu.language_id).order('created_at DESC').page(params[:page])
	end

	def show
		@odania_content = current_site.contents.active.where(id: params[:id].to_i, language_id: current_menu.language_id).first

		return render_not_found if @odania_content.nil?
		return redirect_to odania_content_path(id: @odania_content.to_param) unless @odania_content.to_param.eql? params[:id]

		@widget_id = @odania_content.widget_id
	end
end
