# TODO: Find a way around the include to also allow other background processing
require 'sidekiq'

class ClickWorker
	include Sidekiq::Worker

	def perform(data)
		puts "obj_type: #{data[:obj_type]}"
		puts "id: #{data[:id]}"
		puts "view_date: #{data[:view_date]}"
		puts "referer: #{data[:referer]}"
	end
end
