class CreateUser < ActiveRecord::Migration
	def change
		create_table :odania_users do |t|
			t.integer :site_id
			t.string :name
			t.string :email
			t.string :admin_layout
			t.string :ip
			t.datetime :last_login
			t.timestamps
		end
	end
end
