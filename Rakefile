# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

LOCAL_TEST_MODE = 'development'.eql?(Rails.env) unless defined? 'LOCAL_TEST_MODE'

spec = Gem::Specification.find_by_name 'odania'
Dir[spec.gem_dir + '/tasks/*.rake'].sort.each do |path|
	load path
end
