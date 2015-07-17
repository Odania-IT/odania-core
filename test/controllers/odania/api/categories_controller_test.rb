# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::Api::CategoriesControllerTest < ActionController::TestCase
	def setup
		@language = create(:language)
		@category = create(:category, language: @language, site: @site)
		create_list(:category, 25, language: @language, site: @site)
	end

	test 'test should get index' do
		get :index, {language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should show category' do
		get :show, {id: @category.id, language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should give error on invalid id' do
		get :show, {id: 'asd65dsadsatest-test', language_id: @language.id, site_id: @site.id, format: :json}
		assert_response :bad_request
	end
end
