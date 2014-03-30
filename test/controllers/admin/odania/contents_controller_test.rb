# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Odania::ContentsControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@language = create(:language)
		@menu = create(:menu_with_items, site: site, amount: 4, language: site.default_language)
	end

	test 'test should get index' do
		get :index, {menu_id: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:admin_contents)
	end

	test 'test should show content' do
		get :show, {id: @content.id.to_s, menu_id: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:admin_content)
	end

	test 'test should redirect on invalid id' do
		get :show, {id: 'asd65dsadsatest-test', menu_id: @menu.id.to_s}
		assert_response :redirect
		assert_redirected_to admin_odania_menu_odania_contents_path
	end

	test 'should render new content' do
		get :new, {menu_id: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:admin_content)
	end

	test 'should render edit content' do
		get :edit, {id: @content.id.to_s, menu_id: @menu.id.to_s}
		assert_response :success
		assert_not_nil assigns(:admin_content)
	end

	test 'should create content' do
		data = {title: 'Test Title', body: 'ContentBody', body_short: 'Short', published_at: Time.now,
				  language_id: @language.id.to_s, site_id: @content.site.id}
		assert_difference 'Odania::Content.count' do
			post :create, {odania_content: data, menu_id: @menu.id.to_s}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menu_odania_contents_path
	end

	test 'should update content' do
		data = {title: 'Test Title', body: 'ContentBody', body_short: 'Short', published_at: @content.published_at, language_id: @content.language_id}
		post :update, {id: @content.id.to_s, odania_content: data, menu_id: @menu.id.to_s}
		assert_response :redirect
		assert_redirected_to admin_odania_menu_odania_contents_path
	end

	test 'should destroy content' do
		assert_difference 'Odania::Content.count', -1 do
			delete :destroy, {id: @content.id.to_s, menu_id: @menu.id.to_s}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_menu_odania_contents_path
	end
end
