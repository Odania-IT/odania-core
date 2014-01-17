require 'test_helper'

class HelperTest < ActionDispatch::IntegrationTest
	setup do
		create(:default_site)
	end

	test 'user_signed_in_function in called' do
		OdaniaCore.setup do |config|
			config.user_signed_in_function = "'test_user_signed_in'"
			config.current_user_function = "'test_current_user'"
		end

		get '/test/test_current_user'
		assert_response :success
		assert_equal 'test_current_user', response.body

		get '/test/test_signed_in'
		assert_response :success
		assert_equal 'test_user_signed_in', response.body
	end

	# TODO: Check if we can make a proper test for testing the before_filter
	test 'authentication before_filter' do
		OdaniaCore.setup do |config|
			config.authenticate_user_function = "return redirect_to '/'#"
		end

		get '/test/test_authorized'
		assert_response :redirect
	end

	test 'current_site returns site for host' do
		get '/test/test_current_site'
		assert_response :success
		assert_equal 'asd', request.body
	end

	test 'test before_filter without an default site' do
		OdaniaCore::Site.destroy_all
		get '/test/test_valid_site'
		assert_response :service_unavailable

		assert_equal 'There is no (default)-site defined!', request.body
	end

	test 'test before_filter without an active site' do
		default_site = create(:default_site)
		get '/test/test_valid_site'
		assert_response :redirect
		assert_redirected_to "http://#{default_site.host}"
	end

	test 'test before_filter for active site' do
		site = create(:site)
		host! site.host
		get '/test/test_valid_site'
		assert_response :success
		assert_equal 'ok', request.body
	end
end

