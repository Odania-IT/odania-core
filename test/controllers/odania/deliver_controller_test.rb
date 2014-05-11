# -*- encoding : utf-8 -*-
require 'test_helper'

module TestBackgroundWorker
	mattr_accessor :result

	class << self
		def enqueue(tracking_type, opts)
			TestBackgroundWorker.result = "I got called with #{tracking_type} #{opts}"
		end
	end
end

class Odania::DeliverControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
	end

	test 'test should redirect to target' do
		target = 'http://www.mylyconet.com/mikepetersen/'
		Odania.setup do |config|
			config.background_enqueue = 'TestBackgroundWorker.enqueue'
		end
		Odania.setup_enqueue

		get :click, {target: URI.escape(target), id: 'myid', type: 'test-type'}
		assert_response :redirect
		assert_redirected_to target
		assert_match /I got called with ClickWorker/, TestBackgroundWorker.result
		assert_match /obj_type.*"test-type"/, TestBackgroundWorker.result
		assert_match /id.*"myid"/, TestBackgroundWorker.result
	end
end
