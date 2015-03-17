# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::Api::UsersControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@language = create(:language)
		@menu = create(:menu_with_items, site: @site, amount: 4, language: @site.default_language)
		@content = create(:content, site: @site, language: @site.default_language)
	end

	test 'test should get user' do
		get :me, {format: :json}
		assert_response :success
	end
end
