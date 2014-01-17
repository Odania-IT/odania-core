require 'test_helper'

class HelperTest < ActionDispatch::IntegrationTest
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
end

