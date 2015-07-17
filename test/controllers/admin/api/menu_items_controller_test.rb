# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Api::MenuItemsControllerTest < ActionController::TestCase
	def setup
		@request.host = @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 4, language: @site.default_language)
	end

	test 'test should get index' do
		get :index, {menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should show content' do
		get :show, {id: @menu.menu_items.first.id.to_s, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should redirect on invalid id' do
		get :show, {id: 'asd65dsadsatest-test', menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :bad_request
	end

	test 'should create content' do
		content = create(:content)

		data = {title: 'Test Title', published: true, target_type: 'CONTENT'}
		assert_difference 'Odania::MenuItem.count' do
			post :create, {menu_item: data, target_data: {id: content.id}, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		end
		assert_response :success
	end

	test 'should update content' do
		data = {title: 'Test Title', published: true, target_type: 'URL'}
		menu_item = @menu.menu_items.first
		target_data = {'url' => 'http://www.perfect-reach.com'}
		post :update, {id: menu_item.id.to_s, menu_item: data, menu_id: @menu.id.to_s, target_data: target_data, site_id: @site.id, format: :json}
		assert_response :success
		menu_item.reload
		assert_equal target_data, menu_item.target_data
		assert_equal data[:title], menu_item.title
		assert_equal data[:published], menu_item.published
		assert_equal data[:target_type], menu_item.target_type
	end

	test 'should destroy content' do
		assert_difference 'Odania::MenuItem.count', -1 do
			delete :destroy, {id: @menu.menu_items.first.id.to_s, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		end
		assert_response :success
	end
end
