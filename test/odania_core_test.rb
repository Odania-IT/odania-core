require 'test_helper'

class OdaniaCoreTest < ActiveSupport::TestCase
	test 'OdaniaCore is a module' do
		assert_kind_of Module, Odania
	end

	test 'configure block yields OdaniaCore::Configuration' do
		Odania.setup do |config|
			assert_equal Odania::Configuration, config
		end
	end

	test 'configuration' do
		Odania.setup do |config|
			config.user_signed_in_function = 'signed_in?'
			config.current_user_function = 'current_user'
		end

		assert_equal 'signed_in?', Odania.config.user_signed_in_function
		assert_equal 'current_user', Odania.config.current_user_function
	end
end
