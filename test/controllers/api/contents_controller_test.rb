# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Api::ContentsControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@language = create(:language)
		@menu = create(:menu_with_items, site: @site, amount: 4, language: @site.default_language)
		@content = create(:content, site: @site, language: @site.default_language)
	end

	test 'test should get index' do
		get :index, {menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should show content' do
		get :show, {id: @content.id.to_s, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'test should redirect on invalid id' do
		get :show, {id: 'asd65dsadsatest-test', menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :bad_request
	end

	test 'should create content' do
		data = {title: 'Test Title', body: 'ContentBody', body_short: 'Short', published_at: Time.now,
				  language_id: @language.id.to_s, site_id: @content.site.id}
		assert_difference 'Odania::Content.count' do
			post :create, {content: data, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		end
		assert_response :success
	end

	test 'should update content' do
		data = {title: 'Test Title', body: 'ContentBody', body_short: 'Short', published_at: @content.published_at, language_id: @content.language_id}
		post :update, {id: @content.id.to_s, content: data, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		assert_response :success
	end

	test 'should destroy content' do
		assert_difference 'Odania::Content.count', -1 do
			delete :destroy, {id: @content.id.to_s, menu_id: @menu.id.to_s, site_id: @site.id, format: :json}
		end
		assert_response :success
	end
end
