module Odania
	class Configuration
		mattr_accessor :page_404
		@@page_404 = {template: 'odania/common/not_found_error', layout: 'layouts/odania_core/error'}
	end
end
