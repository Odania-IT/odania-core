class CreateOdaniaUserRoles < ActiveRecord::Migration
	def change
		create_table :odania_user_roles do |t|
			t.integer :user_id
			t.integer :role, default: 0
		end

		add_index :odania_user_roles, [:user_id]
	end
end
