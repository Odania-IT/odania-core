# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::Api::ContentsControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@language = create(:language)
		@menu = create(:menu_with_items, site: @site, amount: 4, language: @site.default_language)
		@content = create(:content, site: @site, language: @site.default_language)
	end

	test 'test should get index' do
		get :index, params: {language_id: @menu.language_id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should show content' do
		get :show, params: {id: @content.id, language_id: @menu.language_id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should give error on invalid id' do
		get :show, params: {id: 'asd65dsadsatest-test', language_id: @menu.language_id, site_id: @site.id, format: :json}
		assert_response :bad_request
	end
end
