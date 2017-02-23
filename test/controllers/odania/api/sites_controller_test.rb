# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::Api::SitesControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@language = create(:language)
	end

	test 'test should get index' do
		get :index, params: {format: :json}
		assert_response :success
	end

	test 'test should show site' do
		get :show, params: {id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should give error on invalid id' do
		get :show, params: {id: 'asd65dsadsatest-test', format: :json}
		assert_response :bad_request
	end
end
