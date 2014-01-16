require 'test_helper'

class OdaniaCoreTest < ActiveSupport::TestCase
	test "OdaniaCore is a module" do
		assert_kind_of Module, OdaniaCore
	end

	test 'configure block yields OdaniaCore::Configuration' do
		OdaniaCore.configure do |config|
			assert_equal OdaniaCore::Configuration, config
		end
	end

	test 'configuration' do
		OdaniaCore.configure do |config|
			config.user_signed_in_function = 'signed_in?'
			config.current_user_function = 'current_user'
		end

		assert_equal 'signed_in?', OdaniaCore.config.user_signed_in_function
		assert_equal 'current_user', OdaniaCore.config.current_user_function
	end
end
