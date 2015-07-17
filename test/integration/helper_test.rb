require 'test_helper'

class HelperTest < ActionDispatch::IntegrationTest
	setup do
		@default_site = create(:default_site)
	end

	test 'current_site returns site for host' do
		site = create(:site)
		host! site.host
		get '/test/test_current_site'
		assert_response :success
		assert_equal '{"host":"'+site.host+'","is_active":true}', response.body
	end

	test 'test before_filter without an default site' do
		Odania::Site.destroy_all
		get '/test/test_valid_site'
		assert_response :service_unavailable

		assert_equal 'There is no (default)-site defined!', response.body
	end

	test 'test before_filter without an active site' do
		get '/test/test_valid_site'
		assert_response :redirect
		assert_redirected_to "http://#{@default_site.host}"
	end

	test 'test before_filter for active site' do
		site = create(:site)
		create(:menu_with_items, site: site, amount: 1, language: site.default_language)

		host! site.host
		get '/test/test_valid_site'
		assert_response :success
		assert_equal 'ok', response.body
	end

	test 'test redirect_to in site redirects to correct site' do
		site = create(:redirect_site)
		host! site.host
		get '/test/test_valid_site'
		assert_response :redirect
		assert_redirected_to "http://#{site.redirect_to.host}"
	end

	test 'test view helpers' do
		menu = create(:menu_with_items, site: @default_site, amount: 1, language: @default_site.default_language)
		host! @default_site.host
		get '/test/test_view_helper', {locale: menu.language.iso_639_1}
		assert_response :success
	end
end

