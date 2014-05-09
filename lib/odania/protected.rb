# Administration related information
module Odania
	module Protected
		# Registered Templates for the protected pages
		mattr_reader :templates
		@@templates = Hash.new

		# Registered Admin Pages
		mattr_accessor :pages
		@@pages = Set.new
	end
end
