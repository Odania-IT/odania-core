class ClickWorker < ActiveJob::Base
	queue_as :default

	def perform(data)
		tracking = Odania::ClickTracking.new
		tracking.obj_type = data[:obj_type]
		tracking.obj_id = data[:id]
		tracking.view_date = Time.at(data[:view_date])
		tracking.referer = data[:referer]
		tracking.save!
	end
end
