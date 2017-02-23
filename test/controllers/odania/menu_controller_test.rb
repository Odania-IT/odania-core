# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::MenuControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'test should render 404' do
		site = create(:site)
		@request.host = site.host

		get :index
		assert_response :not_found
	end

	test 'test should redirect to menu prefix' do
		get :index
		assert_response :redirect
		assert_redirected_to @menu.get_target_path
	end

	test 'test should redirect to menu item target' do
		menu_item = @menu.menu_items.first
		menu_item.target_type = 'URL'
		menu_item.target_data = {'url' => 'http://www.planetech.de'}
		menu_item.save!

		get :menu_index, params: {locale: @menu.language.iso_639_1}
		assert_response :redirect
		assert_redirected_to 'http://www.planetech.de'
	end
end
