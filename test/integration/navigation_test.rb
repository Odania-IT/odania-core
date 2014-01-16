require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
	test 'user_signed_in_function in called' do
		OdaniaCore.setup do |config|
			config.user_signed_in_function = "'test_user_signed_in'"
			config.current_user_function = "'test_current_user'"
		end

		get '/test/test_current_user'
		assert_response :success
		assert_equals '', response.body

		get '/test/test_signed_in'
		assert_response :success
		assert_equals '', response.body
	end
end

