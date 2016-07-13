source 'https://rubygems.org'

gem 'rake', '< 11.0'
gem 'rb-readline'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0', '< 5.1'

gem 'elasticsearch'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'libv8', :platforms => :ruby
gem 'therubyracer', '>= 0.11.4', :platforms => :ruby, :require => 'v8'
gem 'therubyrhino', '>= 0.11.4', :platforms => :jruby


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Puma as the app server
gem 'puma'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug'

	gem 'rspec-rails', '~> 3.0'
end

group :development do
	# Access an IRB console on exception pages or by using <%= console %> in views
	gem 'web-console', '~> 3.0'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'guard', require: false
	gem 'guard-rspec', require: false
	gem 'guard-bundler', require: false
end

group :test do
	gem 'codeclimate-test-reporter'
end

gem 'odania'
gem 'http_accept_language'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
