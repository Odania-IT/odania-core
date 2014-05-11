require 'test_helper'

class SimpleTestWorker
	def perform(param1, param2)
		puts "params: #{param1} | #{param2}"
		@@result = "params: #{param1} | #{param2}"
	end

	def self.result
		@@result
	end
end

class DisabledBackgroundJobTest < ActionDispatch::IntegrationTest
	setup do
		@default_site = create(:default_site)
	end

	test 'disabled background job' do
		Odania.setup do |config|
			config.background_enqueue = 'DisabledBackgroundJob.enqueue'
		end
		Odania.setup_enqueue

		Odania.enqueue(SimpleTestWorker, 'Parameter1', 'Parameter2')
		assert_equal 'params: Parameter1 | Parameter2', SimpleTestWorker.result
	end
end
