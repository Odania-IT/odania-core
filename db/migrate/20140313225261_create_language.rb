class CreateLanguage < ActiveRecord::Migration
	def change
		create_table :languages do |t|
			t.string :name
			t.string :iso_639_1
		end

		add_index :languages, [:iso_639_1], unique: true
	end
end
