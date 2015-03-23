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
	end
end
