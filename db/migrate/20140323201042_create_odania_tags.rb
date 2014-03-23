class CreateOdaniaTags < ActiveRecord::Migration
	def change
		create_table :tags do |t|
			t.string :name, null: false
			t.integer :count, default: 0
		end

		add_index :tags, [:name], unique: true
	end
end
