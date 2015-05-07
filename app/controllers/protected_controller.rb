class ProtectedController < ApplicationController
	before_action :authenticate_user!
	before_action :valid_site!, :valid_menu!
	layout :set_protected_layout

	protected

	def set_protected_layout
		Odania.protected.templates.keys.first || 'odania_core/protected'
	end

	def verify_plugin_active!(name)
		redirect_to protected_path, notice: t('Not allowed') unless current_site.plugin_active?(name)
	end
end
