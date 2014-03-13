class CreateMenuItems < ActiveRecord::Migration
	def change
		create_table :menu_items do |t|
			t.integer :menu_id
			t.string :title
			t.boolean :published
			t.string :target_type
			t.text :target_data
			t.integer :parent_id
		end

		add_index :menu_items, [:menu_id]
	end
end
