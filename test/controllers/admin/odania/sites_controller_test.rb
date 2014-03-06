# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Odania::SitesControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@site = @content.site
	end

	test 'test should get index' do
		get :index
		assert_response :success
		assert_not_nil assigns(:admin_sites)
	end

	test 'test should show content' do
		get :show, id: @site.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'test should redirect on invalid id' do
		get :show, id: 'asd65dsadsatest-test'
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should render new content' do
		get :new
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'should render edit content' do
		get :edit, id: @site.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'should create content' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK',
				  description: 'description is here', template: 'ASDASD', language_id: @site.language_id}
		Odania.templates << 'ASDASD'
		assert_difference 'Odania::Site.count' do
			post :create, {odania_site: data}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should not create content due to invalid template' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK', description: 'description is here', template: 'ASDASD'}
		Odania.templates.clear
		post :create, {odania_site: data}
		assert_response :success
		assert_template :new
	end

	test 'should update content' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK', description: 'description is here'}
		post :update, {id: @site.id.to_s, odania_site: data}
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should destroy content' do
		assert_difference 'Odania::Site.count', -1 do
			delete :destroy, id: @site.id.to_s
		end
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end
end
