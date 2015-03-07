# Administration related information
module Odania
	module Admin
		# Registered Templates for the admin pages
		mattr_reader :templates
		@@templates = Hash.new

		# Registered Admin Pages
		mattr_accessor :pages
		@@pages = {global: Set.new, site: Set.new}

		@@pages[:global] << {name: 'Dashboard', in_menu: true, path: '/dashboard', controller: 'DashboardController', template: 'dashboard/index'}

		@@pages[:global] << {name: 'Sites', in_menu: true, path: '/sites', controller: 'SitesController', template: 'sites/index'}
		@@pages[:global] << {name: 'New Site', in_menu: false, path: '/sites/new', controller: 'EditSiteController', template: 'sites/edit'}
		@@pages[:global] << {name: 'Show Site', in_menu: false, path: '/sites/:id', controller: 'SiteController', template: 'sites/show'}
		@@pages[:global] << {name: 'Edit Site', in_menu: false, path: '/sites/:id/edit', controller: 'EditSiteController', template: 'sites/edit'}

		@@pages[:site] << {name: 'Contents', in_menu: true, path: '/contents', controller: 'ContentsController', template: 'contents/index'}
		@@pages[:site] << {name: 'New Contents', in_menu: false, path: '/contents/new', controller: 'EditContentController', template: 'contents/edit'}
		@@pages[:site] << {name: 'Show Contents', in_menu: false, path: '/contents/:id', controller: 'ContentController', template: 'contents/show'}
		@@pages[:site] << {name: 'Edit Contents', in_menu: false, path: '/contents/:id/edit', controller: 'EditContentController', template: 'contents/edit'}

		@@pages[:global] << {name: 'Languages', in_menu: true, path: '/languages', controller: 'LanguagesController', template: 'languages/index'}
		@@pages[:global] << {name: 'New Languages', in_menu: false, path: '/languages/new', controller: 'EditLanguageController', template: 'languages/edit'}
		@@pages[:global] << {name: 'Show Languages', in_menu: false, path: '/languages/:id', controller: 'LanguageController', template: 'languages/show'}
		@@pages[:global] << {name: 'Edit Languages', in_menu: false, path: '/languages/:id/edit', controller: 'EditLanguageController', template: 'languages/edit'}

		@@pages[:site] << {name: 'Menu', in_menu: true, path: '/menus', controller: 'MenuController', template: 'menus/index'}
		@@pages[:site] << {name: 'New Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/new', controller: 'EditMenuItemController', template: 'menu_items/edit'}
		@@pages[:site] << {name: 'Show Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/:id', controller: 'MenuItemController', template: 'menu_items/show'}
		@@pages[:site] << {name: 'Edit Menu Items', in_menu: false, path: '/menus/:menuId/menu_items/:id/edit', controller: 'EditMenuItemController', template: 'menu_items/edit'}

		@@pages[:site] << {name: 'Widgets', in_menu: true, path: '/widgets', controller: 'WidgetsController', template: 'widgets/index'}
		@@pages[:site] << {name: 'New Widgets', in_menu: false, path: '/widgets/new', controller: 'EditWidgetController', template: 'widgets/edit'}
		@@pages[:site] << {name: 'Show Widgets', in_menu: false, path: '/widgets/:id', controller: 'WidgetController', template: 'widgets/show'}
		@@pages[:site] << {name: 'Edit Widgets', in_menu: false, path: '/widgets/:id/edit', controller: 'EditWidgetController', template: 'widgets/edit'}

		@@pages[:site] << {name: 'Static Pages', in_menu: true, path: '/static_pages', controller: 'StaticPagesController', template: 'static_pages/index'}
		@@pages[:site] << {name: 'New Static Pages', in_menu: false, path: '/static_pages/new', controller: 'EditStaticPageController', template: 'static_pages/edit'}
		@@pages[:site] << {name: 'Show Static Pages', in_menu: false, path: '/static_pages/:id', controller: 'StaticPageController', template: 'static_pages/show'}
		@@pages[:site] << {name: 'Edit Static Pages', in_menu: false, path: '/static_pages/:id/edit', controller: 'EditStaticPageController', template: 'static_pages/edit'}
	end
end
