# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::TagsControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'test should render tag list' do
		get :index
		assert_response :success
		assert_template :index
	end

	test 'test should render existing tag' do
		menu_item = @menu.menu_items.first
		menu_item.target_type = 'CONTENT'
		menu_item.target_data = {'id' => @content.id}
		menu_item.save!

		@content.body = 'This is a #ABC-Tag test'
		@content.menu_item_id = menu_item.id
		@content.save!

		get :show, {tag: 'ABC-Tag'}
		assert_response :success
	end

	test 'test should render not found on invalid tag' do
		get :show, {tag: 'ABC'}
		assert_response :not_found
		assert_template 'odania/common/not_found_error'
	end

	test 'test should set the current_menu_item_id' do
		@content.body = 'This is a #ABC-Tag test'
		@content.menu_item_id = nil
		@content.save!

		get :show, {tag: 'ABC-Tag'}
		assert_response :success
	end
end
