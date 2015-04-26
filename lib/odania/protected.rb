# Administration related information
module Odania
	module Protected
		# Registered Templates for the protected pages
		mattr_reader :templates
		@@templates = Hash.new

		# Registered Plugins
		# a plugin should have protected content that can be enabled per site
		mattr_accessor :plugins
		@@plugins = Set.new

		# Registered Admin Pages
		mattr_accessor :pages
		@@pages = Set.new

		@@pages << {name: 'Media', in_menu: true, path: '/medias', controller: 'MediasController', template: 'medias/index', template_app: 'odania'}
		@@pages << {name: 'New Media', in_menu: false, path: '/medias/new', controller: 'EditMediaController', template: 'medias/edit', template_app: 'odania'}
		@@pages << {name: 'Show Media', in_menu: false, path: '/medias/:id', controller: 'MediaController', template: 'medias/show', template_app: 'odania'}
		@@pages << {name: 'Edit Media', in_menu: false, path: '/medias/:id/edit', controller: 'EditMediaController', template: 'medias/edit', template_app: 'odania'}
	end
end
