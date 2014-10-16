class CreateOdaniaWidgets < ActiveRecord::Migration
	def change
		create_table :odania_widgets do |t|
			t.integer :site_id, null: false, index: true
			t.integer :user_id, null: false, index: true
			t.integer :language_id, null: false, index: true
			t.string :template
			t.string :name
			t.text :content
			t.timestamps
		end
	end
end
