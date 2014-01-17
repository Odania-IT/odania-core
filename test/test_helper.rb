# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require "rails/test_help"

require 'minitest/reporters'
MiniTest::Reporters.use!

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load factories
Dir[Rails.root.join("#{File.dirname(__FILE__)}/factories/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
	# Add more helper methods to be used by all tests here...
	include FactoryGirl::Syntax::Methods
end

# Setup database cleaner
DatabaseCleaner.strategy = :truncation
module DatabaseCleanerModule
	def before_setup
		DatabaseCleaner.start
	end

	def after_teardown
		DatabaseCleaner.clean
		OdaniaCore::Controllers::Helpers.class_variable_set(:@@current_site, nil)
	end
end

class MiniTest::Unit::TestCase
	include DatabaseCleanerModule
end
