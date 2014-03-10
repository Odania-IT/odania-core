# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Odania::MenusControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@menu = create(:menu)
	end

	test 'test should get index' do
		get :index
		assert_response :success
		assert_not_nil assigns(:admin_menus)
	end

	test 'test should show content' do
		get :show, id: @menu.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_menu)
	end

	test 'test should redirect on invalid id' do
		get :show, id: 'asd65dsadsatest-test'
		assert_response :redirect
		assert_redirected_to admin_odania_menus_path
	end

	test 'should render new content' do
		get :new
		assert_response :success
		assert_not_nil assigns(:admin_menu)
	end

	test 'should render edit content' do
		get :edit, id: @menu.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_menu)
	end

	test 'should create content' do
		data = {title: 'Test Title', published: true}
		assert_difference 'Odania::Menu.count' do
			post :create, {odania_menu: data}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menus_path
	end

	test 'should update content' do
		data = {title: 'Test Title', published: true}
		post :update, {id: @menu.id.to_s, odania_menu: data}
		assert_response :redirect
		assert_redirected_to admin_odania_menus_path
	end

	test 'should destroy content' do
		assert_difference 'Odania::Menu.count', -1 do
			delete :destroy, id: @menu.id.to_s
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menus_path
	end
end
