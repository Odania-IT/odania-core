# This is meant as a fallback/test background processor. It directly executes the action.
module Odania
	module DisabledBackgroundJob
		def self.enqueue(background_type, opts)
			# Background jobs should not interfere with the server response
			begin
				Rails.logger.info "Directly processing: #{background_type} with options: #{opts}"
				background_type.to_s.constantize.new.perform(*opts)
			rescue => e
				Rails.logger.error "Error in background_job: #{background_type}"
				Rails.logger.error e
			end
		end
	end
end
