class CreateOdaniaMedia < ActiveRecord::Migration
	def change
		create_table :odania_media do |t|
			t.string :title
			t.integer :site_id
			t.integer :language_id
			t.integer :user_id
			t.string :copyright
			t.boolean :is_global
			t.timestamps null: false
		end

		add_attachment :odania_media, :image
		add_index :odania_media, [:site_id, :language_id]
	end
end
