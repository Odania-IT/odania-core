class RemoveMenuItemFromContent < ActiveRecord::Migration
	def change
		remove_column :odania_contents, :menu_item_id
		remove_column :odania_contents, :current_menu_item_id
	end
end
