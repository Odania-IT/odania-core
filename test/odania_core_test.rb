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
end
