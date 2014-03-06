# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Odania::LanguagesControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@language = create(:language)
	end

	test 'test should get index' do
		get :index
		assert_response :success
		assert_not_nil assigns(:admin_languages)
	end

	test 'test should show content' do
		get :show, id: @language.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_language)
	end

	test 'test should redirect on invalid id' do
		get :show, id: 'asd65dsadsatest-test'
		assert_response :redirect
		assert_redirected_to admin_odania_languages_path
	end

	test 'should render new content' do
		get :new
		assert_response :success
		assert_not_nil assigns(:admin_language)
	end

	test 'should render edit content' do
		get :edit, id: @language.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_language)
	end

	test 'should create content' do
		data = {name: 'Engilish', iso_639_1: 'en'}
		assert_difference 'Odania::Language.count' do
			post :create, {admin_language: data}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_languages_path
	end

	test 'should update content' do
		data = {name: 'Engilish', iso_639_1: 'en'}
		post :update, {id: @language.id.to_s, admin_language: data}
		assert_response :redirect
		assert_redirected_to admin_odania_languages_path
	end

	test 'should destroy content' do
		assert_difference 'Odania::Language.count', -1 do
			delete :destroy, id: @language.id.to_s
		end
		assert_response :redirect
		assert_redirected_to admin_odania_languages_path
	end
end
