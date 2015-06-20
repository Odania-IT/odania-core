$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'odania_core/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name = 'odania_core'
	s.version = OdaniaCore::VERSION
	s.authors = ['Mike Petersen']
	s.email = ['mike@odania-it.de']
	s.homepage = 'http://www.odania.com'
	s.summary = 'Core Module of the Odania Portal'
	s.description = 'The Odania Portal is an open source portal system with strong focus on the usage on different domains with different layout/setup.'

	s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
	s.test_files = Dir['test/**/*']

	s.add_dependency 'rails', '~> 4.2.0'
	s.add_dependency 'nokogiri'
	s.add_dependency 'paperclip', '~> 4'
	s.add_dependency 'sass-rails', '~> 5.0.1'
	s.add_dependency 'bootstrap-sass', '~> 3.1.1'
	s.add_dependency 'coffee-rails', '~> 4.1.0'
	s.add_dependency 'jquery-rails'
	s.add_dependency 'kaminari'
	s.add_dependency 'rack-cors'

	# Newer sanitize version >= 3 is not compatible with jruby due to dependency on nokogumbo
	s.add_dependency 'sanitize', '~> 2.1'
	s.add_dependency 'http_accept_language'
	s.add_dependency 'rails-i18n'
	s.add_dependency 'autoprefixer-rails'
	s.add_dependency 'angularjs-rails'
	s.add_dependency 'angular-ui-bootstrap-rails'
	s.add_dependency 'jbuilder'
	s.add_dependency 'responders', '~> 2.0'
	s.add_dependency 'font-awesome-rails'
	s.add_dependency 'uglifier', '>= 1.3.0'
	s.add_dependency 'fb_graph2'
	s.add_dependency 'oj'

	s.add_development_dependency 'ffaker'
end
