require 'odania/worker'

class ClickWorker
	include Odania::Worker

	def perform(data)
		puts "obj_type: #{data[:obj_type]}"
		puts "id: #{data[:id]}"
		puts "view_date: #{data[:view_date]}"
		puts "referer: #{data[:referer]}"
	end
end
