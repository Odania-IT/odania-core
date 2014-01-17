$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "odania_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name = 'odania_core'
	s.version = OdaniaCore::VERSION
	s.authors = ['Mike Petersen']
	s.email = ['mike@odania-it.de']
	s.homepage = 'http://www.odania.de'
	s.summary = 'Core Module of the Odania Portal'
	s.description = 'The Odania Portal is an open source portal system with strong focus on the usage on different domains with different layout/setup.'

	s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
	s.test_files = Dir['test/**/*']

	s.add_dependency 'rails', '~> 4.0.2'
	s.add_dependency 'mongoid'

	s.add_development_dependency 'minitest'
	s.add_development_dependency 'minitest-reporters'
	s.add_development_dependency 'factory_girl_rails'
	s.add_development_dependency 'database_cleaner'
end
