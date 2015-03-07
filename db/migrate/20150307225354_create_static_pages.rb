class CreateStaticPages < ActiveRecord::Migration
	def change
		create_table :odania_static_pages do |t|
			t.string :title
			t.text :body
			t.integer :clicks
			t.integer :views
			t.integer :site_id
			t.integer :language_id
			t.integer :user_id
			t.integer :widget_id
			t.boolean :is_global
			t.timestamps null: false
		end
	end
end
