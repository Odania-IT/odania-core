class RemoveTitleFromMenu < ActiveRecord::Migration
	def change
		remove_column :odania_menus, :title
	end
end
