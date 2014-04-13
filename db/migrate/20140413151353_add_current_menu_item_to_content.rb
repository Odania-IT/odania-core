class AddCurrentMenuItemToContent < ActiveRecord::Migration
	def change
		add_column :odania_contents, :current_menu_item_id, :integer
	end
end
