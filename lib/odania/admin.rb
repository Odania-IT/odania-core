# Administration related information
module Odania
	module Admin
		# Registered Templates for the admin pages
		mattr_reader :templates
		@@templates = Hash.new

		# Registered Admin Pages
		mattr_accessor :pages
		@@pages = Set.new
		@@pages << {name: 'Dashboard', in_menu: true, path: '/dashboard', controller: 'DashboardController', template: 'dashboard/index'}

		@@pages << {name: 'Sites', in_menu: true, path: '/sites', controller: 'SitesController', template: 'sites/index'}
		@@pages << {name: 'New Site', in_menu: false, path: '/sites/new', controller: 'EditSiteController', template: 'sites/edit'}
		@@pages << {name: 'Show Site', in_menu: false, path: '/sites/:id', controller: 'SiteController', template: 'sites/show'}
		@@pages << {name: 'Edit Site', in_menu: false, path: '/sites/:id/edit', controller: 'EditSiteController', template: 'sites/edit'}

		@@pages << {name: 'Contents', in_menu: true, path: '/contents', controller: 'ContentsController', template: 'contents/index'}
		@@pages << {name: 'New Contents', in_menu: false, path: '/contents/new', controller: 'EditContentController', template: 'contents/edit'}
		@@pages << {name: 'Show Contents', in_menu: false, path: '/contents/:id', controller: 'ContentController', template: 'contents/show'}
		@@pages << {name: 'Edit Contents', in_menu: false, path: '/contents/:id/edit', controller: 'EditContentController', template: 'contents/edit'}

		@@pages << {name: 'Languages', in_menu: true, path: '/languages', controller: 'LanguagesController', template: 'languages/index'}
		@@pages << {name: 'New Languages', in_menu: false, path: '/languages/new', controller: 'EditLanguageController', template: 'languages/edit'}
		@@pages << {name: 'Show Languages', in_menu: false, path: '/languages/:id', controller: 'LanguageController', template: 'languages/show'}
		@@pages << {name: 'Edit Languages', in_menu: false, path: '/languages/:id/edit', controller: 'EditLanguageController', template: 'languages/edit'}

		@@pages << {name: 'Menus', in_menu: true, path: '/menus', controller: 'MenusController', template: 'menus/index'}
		@@pages << {name: 'New Menus', in_menu: false, path: '/menus/new', controller: 'EditMenuController', template: 'menus/edit'}
		@@pages << {name: 'Show Menus', in_menu: false, path: '/menus/:id', controller: 'MenuController', template: 'menus/show'}
		@@pages << {name: 'Edit Menus', in_menu: false, path: '/menus/:id/edit', controller: 'EditMenuController', template: 'menus/edit'}

		@@pages << {name: 'Menu Items', in_menu: false, path: '/menus/:menuId/menu_items', controller: 'MenuItemsController', template: 'menu_items/index'}
		@@pages << {name: 'New Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/new', controller: 'EditMenuItemController', template: 'menu_items/edit'}
		@@pages << {name: 'Show Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/:id', controller: 'MenuItemController', template: 'menu_items/show'}
		@@pages << {name: 'Edit Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/:id/edit', controller: 'EditMenuItemController', template: 'menu_items/edit'}

		@@pages << {name: 'Widgets', in_menu: true, path: '/widgets', controller: 'WidgetsController', template: 'widgets/index'}
		@@pages << {name: 'New Widgets', in_menu: false, path: '/widgets/new', controller: 'EditWidgetController', template: 'widgets/edit'}
		@@pages << {name: 'Show Widgets', in_menu: false, path: '/widgets/:id', controller: 'WidgetController', template: 'widgets/show'}
		@@pages << {name: 'Edit Widgets', in_menu: false, path: '/widgets/:id/edit', controller: 'EditWidgetController', template: 'widgets/edit'}
	end
end
