# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Odania::MenuItemsControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@menu = create(:menu_with_items, site: site, amount: 4, language: site.default_language)
	end

	test 'test should get index' do
		get :index, {odania_menu: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:odania_menu_items)
	end

	test 'test should show content' do
		get :show, {id: @menu.menu_items.first.id.to_s, odania_menu: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:odania_menu_item)
	end

	test 'test should redirect on invalid id' do
		get :show, {id: 'asd65dsadsatest-test', odania_menu: @menu.id.to_s}
		assert_response :redirect
		assert_redirected_to admin_odania_menu_items_path(odania_menu: @menu.id.to_s)
	end

	test 'should render new content' do
		get :new, {odania_menu: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:odania_menu_item)
	end

	test 'should render edit content' do
		get :edit, {id: @menu.menu_items.first.id.to_s, odania_menu: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:odania_menu_item)
	end

	test 'should create content' do
		data = {title: 'Test Title', published: true}
		assert_difference 'Odania::MenuItem.count' do
			post :create, {odania_menu_item: data, odania_menu: @menu.id.to_s}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menu_items_path(odania_menu: @menu.id.to_s)
	end

	test 'should update content' do
		data = {title: 'Test Title', published: true}
		post :update, {id: @menu.menu_items.first.id.to_s, odania_menu_item: data, odania_menu: @menu.id.to_s}
		assert_response :redirect
		assert_redirected_to admin_odania_menu_items_path(odania_menu: @menu.id.to_s)
	end

	test 'should destroy content' do
		assert_difference 'Odania::MenuItem.count', -1 do
			delete :destroy, {id: @menu.menu_items.first.id.to_s, odania_menu: @menu.id.to_s}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menu_items_path(odania_menu: @menu.id.to_s)
	end
end
