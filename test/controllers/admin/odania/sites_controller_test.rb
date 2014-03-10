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

	test 'test should show site' do
		get :show, id: @site.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'test should redirect on invalid id' do
		get :show, id: 'asd65dsadsatest-test'
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should render new site' do
		get :new
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'should render edit site' do
		get :edit, id: @site.id.to_s
		assert_response :success
		assert_not_nil assigns(:admin_site)
	end

	test 'should create site' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK',
				  description: 'description is here', template: 'ASDASD', language_ids: [@site.default_language_id]}
		Odania.templates['ASDASD'] = {name: 'Test Template', template: 'ASDASD'}
		assert_difference 'Odania::Site.count' do
			post :create, {odania_site: data}
		end
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should not create site due to invalid template' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK',
				  description: 'description is here', template: 'ASDASD', language_ids: [@site.default_language_id]}
		Odania.templates.clear
		post :create, {odania_site: data}
		assert_response :success
		assert_template :new
	end

	test 'should update site' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK', description: 'description is here'}
		post :update, {id: @site.id.to_s, odania_site: data}
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end

	test 'should destroy site' do
		assert_difference 'Odania::Site.count', -1 do
			delete :destroy, id: @site.id.to_s
		end
		assert_response :redirect
		assert_redirected_to admin_odania_sites_path
	end
end
