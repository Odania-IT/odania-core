# Administration related information
module Odania
	module Admin
		# Registered Templates for the admin pages
		mattr_reader :admin_templates
		@@admin_templates = Hash.new

		# Registered Admin Pages
		mattr_accessor :admin_pages
		@@admin_pages = Set.new
		@@admin_pages << {name: 'Sites', path: '/admin/odania/sites'}
		@@admin_pages << {name: 'Contents', path: '/admin/odania/contents'}
		@@admin_pages << {name: 'Languages', path: '/admin/odania/languages'}
		@@admin_pages << {name: 'Menus', path: '/admin/odania/menus'}
	end
end
