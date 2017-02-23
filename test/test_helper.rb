# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rails/test_help'

require 'minitest/reporters'
MiniTest::Reporters.use!

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
Dir[Rails.root.join("#{File.dirname(__FILE__)}/factories/**/*.rb")].each { |f| require f }

require 'simplecov'
SimpleCov.start

# Setup mock config
require 'support/test_setup'
OdaniaTestMock.user_authenticated = true

class ActiveSupport::TestCase
	# Add more helper methods to be used by all tests here...
	include FactoryGirl::Syntax::Methods
end

# Setup database cleaner
DatabaseCleaner.strategy = :transaction
module DatabaseCleanerModule
	def before_setup
		super
		DatabaseCleaner.start
	end

	def after_teardown
		DatabaseCleaner.clean
		Odania::Controllers::UrlHelpers.instance_variable_set(:@current_site, nil)
		super
	end
end

class MiniTest::Unit::TestCase
	include DatabaseCleanerModule
end

# Resetting the setup (otherwise there are some weird side effects)
class ActionController::TestCase
	setup do
		Odania.setup do |config|
			config.user_signed_in_function = 'OdaniaTestMock.signed_in'
			config.current_user_function = 'OdaniaTestMock.current_user'
			config.authenticate_user_function = 'user_auth'
		end
		OdaniaTestMock.user_authenticated = true
	end
end

class ActionDispatch::IntegrationTest
	setup do
		Odania.setup do |config|
			config.user_signed_in_function = 'OdaniaTestMock.signed_in'
			config.current_user_function = 'OdaniaTestMock.current_user'
			config.authenticate_user_function = 'user_auth'
		end
		OdaniaTestMock.user_authenticated = true
	end
end
