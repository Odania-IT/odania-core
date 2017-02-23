# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::ContentsControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
		@request.host = @site.host
		@content = create(:content, site: @site, language: @site.default_language)
	end

	test 'test should render content list' do
		get :index, params: {locale: @site.default_language.iso_639_1}
		assert_response :success
		assert assigns(:odania_contents)
	end

	test 'test should render content list for tag' do
		content = build(:content, site: @site, language: @site.default_language)
		content.body = 'This is a new tag #TZ2'
		content.tag_list = 'TZ2'
		content.save!

		get :index, params: {tag: 'TZ2', locale: @site.default_language.iso_639_1}
		assert_response :success
		assert assigns(:odania_contents)
		assert_equal 1, assigns(:odania_contents).count
	end

	test 'test should render content' do
		get :show, params: {id: @content.to_param, locale: @site.default_language.iso_639_1}
		assert_response :success
		assert assigns(:odania_content)
	end

	test 'test should redirect to correct url content' do
		get :show, params: {id: @content.id, locale: @site.default_language.iso_639_1}
		assert_response :redirect
		assert_redirected_to odania_content_path(id: @content.to_param)
	end

	test 'test should render not found for invalid id' do
		get :show, params: {id: '123123123', locale: @site.default_language.iso_639_1}
		assert_response :not_found
	end
end
