class CreateOdaniaMedia < ActiveRecord::Migration
	def change
		create_table :odania_medias do |t|
			t.string :title
			t.integer :site_id
			t.integer :language_id
			t.integer :user_id
			t.boolean :is_global
			t.timestamps null: false
		end

		add_attachment :odania_medias, :image
		add_index :odania_medias, [:site_id, :language_id]
	end
end
