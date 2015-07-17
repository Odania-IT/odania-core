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

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# Setup mock config
require 'support/test_setup'

class ActiveSupport::TestCase
	# Add more helper methods to be used by all tests here...
	include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
	include Devise::TestHelpers

	setup do
		create(:default_language)
		@site = create(:default_site)
		@request.host = @site.host
		@user = create(:default_user, site: @site)
		create(:user_role, user: @user)
		sign_in @user
	end
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
