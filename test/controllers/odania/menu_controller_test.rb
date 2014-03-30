# -*- encoding : utf-8 -*-
require 'test_helper'

class Odania::MenuControllerTest < ActionController::TestCase
	def setup
		@site = create(:default_site)
		@request.host = @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'test should redirect to default' do
		site = create(:site)
		@request.host = site.host

		get :index
		assert_redirected_to "http://#{@site.host}"
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

		get :menu_index, {menu_title: @menu.prefix}
		assert_response :redirect
		assert_redirected_to 'http://www.planetech.de'
	end

	test 'test should render menu_item' do
		content = create(:content, site: @site)
		menu_item = @menu.menu_items.last
		menu_item.target_type = 'CONTENT'
		menu_item.target_data = {'id' => content.id}
		menu_item.menu_id = @menu.id
		menu_item.save!

		get :show_page, {menu_title: @menu.prefix, path: menu_item.full_path}
		assert_response :success
		assert_template 'odania/contents/_show'
	end

	test 'test should render menu_item which is lying under the parent' do
		content = create(:content, site: @site)
		parent_menu_item = @menu.menu_items.last

		menu_item = create(:menu_item, menu: parent_menu_item.menu)
		menu_item.target_type = 'CONTENT'
		menu_item.target_data = {'id' => content.id}
		menu_item.parent_id = parent_menu_item.id
		menu_item.save!

		get :show_page, {menu_title: @menu.prefix, path: menu_item.full_path}
		assert_response :success
		assert_template 'odania/contents/_show'
	end

	test 'test should render content list' do
		create(:content, site: @site)
		create(:content, site: @site)
		menu_item = create(:menu_item, menu: @menu)
		menu_item.target_type = 'CONTENT_LIST'
		menu_item.target_data = {}
		menu_item.save!

		get :show_page, {menu_title: @menu.prefix, path: menu_item.full_path}
		assert_response :success
		assert_template 'odania/contents/_index'
	end

	test 'test should render item under content list' do
		content = create(:content, site: @site)
		create(:content, site: @site)
		menu_item = create(:menu_item, menu: @menu)
		menu_item.target_type = 'CONTENT_LIST'
		menu_item.target_data = {}
		menu_item.save!

		get :show_page, {menu_title: @menu.prefix, path: menu_item.full_path+'/'+content.to_param}
		assert_response :success
		assert_template 'odania/contents/_show'
	end
end
