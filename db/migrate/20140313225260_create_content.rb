class CreateContent < ActiveRecord::Migration
	def change
		create_table :contents do |t|
			t.string :title, null: false
			t.text :body, null: false
			t.text :body_short, null: false
			t.integer :clicks, default: 0
			t.integer :views, default: 0
			t.datetime :published_at, null: false
			t.boolean :is_active, default: false
			t.integer :site_id, null: false
			t.integer :language_id, null: false
			t.integer :user_id, null: false
			t.timestamps
		end

		add_index :contents, [:site_id, :is_active]
		add_index :contents, [:user_id]
	end
end
