# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::TagsControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site, language: @site.default_language)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'test should render tag list' do
		get :index, {locale: @content.language.iso_639_1}
		assert_response :success
		assert_template :index
	end

	test 'test should render existing tag' do
		menu_item = @menu.menu_items.first
		menu_item.target_type = 'CONTENT'
		menu_item.target_data = {'id' => @content.id}
		menu_item.save!

		@content.body = 'This is a #ABC-Tag test'
		@content.tag_list = 'ABC-Tag'
		@content.save!

		get :show, {tag: 'ABC-Tag', locale: @content.language.iso_639_1}
		assert_response :success
	end

	test 'test should render not found on invalid tag' do
		get :show, {tag: 'ABC', locale: @content.language.iso_639_1}
		assert_response :not_found
		assert_template Odania.config.page_404[:template]
	end

	test 'test auto_complete' do
		get :auto_complete, {term: 'a', locale: @content.language.iso_639_1}
		assert_response :success
	end
end
