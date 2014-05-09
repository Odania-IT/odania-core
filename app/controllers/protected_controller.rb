class ProtectedController < ApplicationController
	before_action :authenticate_user!, :require_admin_role!
	skip_before_filter :valid_site!
	layout :set_protected_layout

	def set_protected_layout
		Odania.protected.templates.keys.first || 'odania_core/protected'
	end
end
