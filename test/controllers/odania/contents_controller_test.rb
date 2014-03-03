# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::ContentsControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
	end

	test 'test should get index' do
		get :index
		assert_response :success
		assert_not_nil assigns(:odania_contents)
	end

	test 'test should show content' do
		get :show, id: @content.id.to_s
		assert_response :success
		assert_not_nil assigns(:odania_content)
	end

	test 'test should render 404 on invalid id' do
		get :show, id: 'asd65dsadsatest-test'
		assert_response :not_found
	end
end
