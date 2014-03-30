class CreateOdaniaTags < ActiveRecord::Migration
	def change
		create_table :tags do |t|
			t.string :name, null: false
			t.integer :site_id, null: false
			t.integer :count, default: 0
		end

		add_index :tags, [:site_id, :name], unique: true
	end
end
