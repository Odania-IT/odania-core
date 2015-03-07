class Admin::Api::WidgetsController < Admin::ApiController
	before_action :verify_widget, except: [:index, :create]
	
	def index
		@widgets = Odania::Widget.where('(site_id = ? OR is_global = ?) AND language_id = ?', params[:site_id], true, params[:language_id]).order('created_at DESC')
	end

	def show
	end

	def create
		@widget = Odania::Widget.new(widget_params)
		@widget.user_id = current_user.id
		@widget.site_id = params[:site_id]
		set_content

		if @widget.save
			flash[:notice] = t('created')
			render action: :show
		else
			render json: {errors: @widget.errors}, status: :bad_request
		end
	end

	def update
		set_content
		if @widget.update(widget_params)
			flash[:notice] = t('updated')
			render action: :show
		else
			render json: {errors: @widget.errors}, status: :bad_request
		end
	end

	def destroy
		@widget.destroy

		flash[:notice] = t('deleted')
		render json: {message: 'deleted'}
	end

	private

	def verify_widget
		@widget = Odania::Widget.where(site_id: params[:site_id], id: params[:id]).first
		bad_api_request('resource_not_found') if @widget.nil?
	end

	def widget_params
		params.require(:widget).permit(:site_id, :template, :name, :content, :language_id, :is_global)
	end

	def set_content
		Odania::widgets.each do |widget|
			if widget[:template].eql? params[:widget][:template]
				if widget[:is_array]
					@widget.content = params[:widget][:content]
				else
					@widget.content = params[:widget][:content]
				end
				return
			end
		end
	end
end
