# -*- encoding : utf-8 -*-
require 'test_helper'

class Protected::DashboardControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@language = create(:language)
		@menu = create(:menu_with_items, site: site, amount: 4, language: site.default_language)
	end

	test 'test should get index' do
		get :index
		assert_response :success
	end
end
