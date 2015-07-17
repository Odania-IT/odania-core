# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::DeliverControllerTest < ActionController::TestCase
	def setup
		@content = create(:content, site: @site)
	end

	test 'test should redirect to target' do
		target = 'http://www.mylyconet.com/mikepetersen/'

		get :click, {target: URI.escape(target), id: 14, type: 'Odania::Content'}
		assert_response :redirect
		assert_redirected_to target

		assert_equal 1, Odania::ClickTracking.where(obj_id: 14, obj_type: 'Odania::Content').count
	end
end
