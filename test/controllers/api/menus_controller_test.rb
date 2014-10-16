# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Api::MenusControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 4, language: @site.default_language)
	end

	test 'test should get index' do
		get :index, site_id: @site.id, format: :json
		assert_response :success
	end

	test 'test should show content' do
		get :show, {id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should redirect on invalid id' do
		get :show, id: 'asd65dsadsatest-test', site_id: @site.id, format: :json
		assert_response :bad_request
	end

	test 'should create content' do
		data = {title: 'Test Title', published: true, language_id: @content.language_id}
		assert_difference 'Odania::Menu.count' do
			post :create, {menu: data, site_id: @site.id, format: :json}
		end
		assert_response :success
	end

	test 'should update content' do
		data = {title: 'Test Title', published: true, language_id: @content.language_id}
		post :update, {id: @menu.id.to_s, menu: data, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'should destroy content' do
		assert_difference 'Odania::Menu.count', -1 do
			delete :destroy, id: @menu.id.to_s, site_id: @site.id, format: :json
		end
		assert_response :success
	end
end
