class Odania::DeliverController < ApplicationController
	def click
		target = URI.unescape(params[:target])

		# Tracking data
		obj_type = params[:type].to_s
		id = params[:id].to_s

		Odania.enqueue('ClickWorker', {obj_type: obj_type, id: id, view_date: Time.now, referer: request.referer})

		redirect_to target
	end
end
