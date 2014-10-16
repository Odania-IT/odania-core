class Admin::TemplateController < AdminController
	def index
		@template = params[:template].to_s.gsub(/[^a-z0-9\/]/, '_')
		render layout: nil
	end
end
