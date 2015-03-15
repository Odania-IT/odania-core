# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::CategoriesControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@category = create(:category, site: @site, language: @site.default_language)
		@content = create(:content, site: @site, language: @site.default_language, category_list: @category.title)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'test should render category list' do
		get :index, {locale: @content.language.iso_639_1}
		assert_response :success
		assert_template :index
	end

	test 'test should render existing category' do
		@content.body = 'This is a #ABC-Tag test'
		@content.tag_list = 'ABC-Tag'
		@content.save!

		get :show, {id: @category.id, locale: @content.language.iso_639_1}
		assert_response :success
		assert_match "/#{@content.language.iso_639_1}/contents/#{@content.to_param}", @response.body
	end

	test 'test should render not found on invalid category' do
		get :show, {id: 666, locale: @content.language.iso_639_1}
		assert_response :not_found
		assert_template Odania.config.page_404[:template]
	end

	test 'test should not render inactive item' do
		@content.body = 'This is a #ABC-Tag test'
		@content.tag_list = 'ABC-Tag'
		@content.state = 'DRAFT'
		@content.save!

		get :show, {id: @category.id, locale: @content.language.iso_639_1}
		assert_response :success
		assert_no_match "/#{@content.language.iso_639_1}/contents/#{@content.to_param}", @response.body
	end
end
