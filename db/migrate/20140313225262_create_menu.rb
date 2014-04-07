class CreateMenu < ActiveRecord::Migration
	def change
		create_table :odania_menus do |t|
			t.string :title
			t.boolean :published
			t.integer :default_menu_item_id
			t.integer :site_id
			t.integer :language_id
			t.timestamps
		end

		add_index :odania_menus, [:site_id, :language_id], unique: true
	end
end
