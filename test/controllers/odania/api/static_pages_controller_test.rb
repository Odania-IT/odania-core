# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::Api::StaticPagesControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@language = create(:language)
		@static_page = create(:static_page, language: @language, site: @site)
	end

	test 'test should get index' do
		get :index, params: {language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should show static page' do
		get :show, params: {id: @static_page.id, language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should give error on invalid id' do
		get :show, params: {id: 'asd65dsadsatest-test', language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :bad_request
	end
end
