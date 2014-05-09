# Administration related information
module Odania
	module Admin
		# Registered Templates for the admin pages
		mattr_reader :templates
		@@templates = Hash.new

		# Registered Admin Pages
		mattr_accessor :pages
		@@pages = Set.new
		@@pages << {name: 'Sites', path: '/admin/odania/sites'}
		@@pages << {name: 'Contents', path: '/admin/odania/contents'}
		@@pages << {name: 'Languages', path: '/admin/odania/languages'}
		@@pages << {name: 'Menus', path: '/admin/odania/menus'}
		@@pages << {name: 'Menu Items', path: '/admin/odania/menu_items'}
	end
end
