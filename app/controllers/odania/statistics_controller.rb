class Odania::StatisticsController < ApplicationController
	include Viewable

	def track_view
		updated = false
		class_name = params[:type].nil? ? '' : params[:type].to_s

		if Odania.trackable_classes.include? class_name
			obj = class_name.constantize.where(id: params[:id].to_i).first

			unless obj.nil?
				updated = update_view_count(obj)
			end
		end

		render :text => updated ? 'updated' : 'duplicate'
	end
end
