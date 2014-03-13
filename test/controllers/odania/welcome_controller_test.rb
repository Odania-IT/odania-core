# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::WelcomeControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
	end

	test 'test should get index if no menu is defined' do
		get :index
		assert_response :success
		assert_template :index
	end

	test 'test should redirect to first parent menu item' do
		menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
		menu_item = menu.menu_items.first

		get :index
		assert_response :redirect
		assert_redirected_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data)
	end

	test 'test should redirect to default menu item' do
		menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
		menu_item = create(:menu_item, menu: menu)
		menu.default_menu_item = menu_item
		menu.save!

		get :index
		assert_response :redirect
		assert_redirected_to Odania::TargetType.get_target(menu_item.target_type, menu_item.target_data)
	end
end
