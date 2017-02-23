# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Api::LanguagesControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@language = create(:language)
	end

	test 'test should get index' do
		get :index, params: {format: :json}
		assert_response :success
	end

	test 'test should show content' do
		get :show, params: {id: @language.id.to_s, format: :json}
		assert_response :success
	end

	test 'test should redirect on invalid id' do
		get :show, params: {id: 'asd65dsadsatest-test', format: :json}
		assert_response :bad_request
	end

	test 'should create content' do
		data = {name: 'English', iso_639_1: 'en'}
		assert_difference 'Odania::Language.count' do
			post :create, params: {language: data, format: :json}
		end
		assert_response :success
	end

	test 'should update content' do
		data = {name: 'English2', iso_639_1: 'en2'}
		post :update, params: {id: @language.id.to_s, language: data, format: :json}
		assert_response :success
	end

	test 'should destroy content' do
		assert_difference 'Odania::Language.count', -1 do
			delete :destroy, params: {id: @language.id.to_s, format: :json}
		end
		assert_response :success
	end
end
