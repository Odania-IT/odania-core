class ProcessErrorJob < ApplicationJob
	queue_as :default

	def perform(data)
		# TODO: write to database
		data = JSON.parse data
		puts data.inspect
	end
end
