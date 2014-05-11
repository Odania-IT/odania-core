# This is meant as a fallback/test background processor. It directly executes the action.
module DisabledBackgroundJob
	def self.enqueue(background_type, opts)
		puts "Directly processing: #{background_type} with options: #{opts}"
		background_type.to_s.constantize.new.perform(*opts)
	end
end
