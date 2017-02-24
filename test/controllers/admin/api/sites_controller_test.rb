# -*- encoding : utf-8 -*-
require 'test_helper'

class Admin::Api::SitesControllerTest < ActionController::TestCase
	def setup
		site = create(:default_site)
		@request.host = site.host
		@content = create(:content, site: site)
		@site = @content.site
	end

	test 'test should get index' do
		get :index, params: {format: :json}
		assert_response :success
	end

	test 'test should show site' do
		get :show, params: {id: @site.id.to_s, format: :json}
		assert_response :success
	end

	test 'test should redirect on invalid id' do
		get :show, params: {id: 'asd65dsadsatest-test', format: :json}
		assert_response :bad_request
	end

	test 'should create site' do
		data = {name: 'Page1', domain: 'test.de', subdomain: 'www', is_active: true, tracking_code: 'TRACK',
				  description: 'description is here', template: 'ASDASD', default_language_id: @site.default_language_id}
		Odania.templates['ASDASD'] = {name: 'Test Template', template: 'ASDASD'}
		assert_difference 'Odania::Site.count' do
			post :create, params: {site: data, format: :json}
		end
		assert_response :success
	end

	test 'should not create site due to invalid template' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK',
				  description: 'description is here', template: 'ASDASD'}
		Odania.templates.clear
		assert_difference 'Odania::Site.count', 0 do
			post :create, params: {site: data, format: :json}
		end
		assert_response :bad_request
	end

	test 'should update site' do
		data = {name: 'Page1', host: 'www.test.de', is_active: true, tracking_code: 'TRACK', description: 'description is here'}
		post :update, params: {id: @site.id.to_s, site: data, format: :json}
		assert_response :success
	end

	# TODO: What should happen with the content, etc?
	#test 'should destroy site' do
	#	assert_difference 'Odania::Site.count', -1 do
	#		delete :destroy, id: @site.id.to_s, format: :json
	#	end
	#	assert_response :success
	#end
end