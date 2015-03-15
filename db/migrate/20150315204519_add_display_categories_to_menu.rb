class AddDisplayCategoriesToMenu < ActiveRecord::Migration
	def change
		add_column :odania_menus, :display_categories, :boolean, default: true
	end
end
