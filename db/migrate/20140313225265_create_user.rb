class CreateUser < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :name
			t.string :admin_layout
			t.timestamps
		end
	end
end
