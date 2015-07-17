class CreateUserAuthentications < ActiveRecord::Migration
	def change
		create_table :odania_user_authentications do |t|
			t.integer :user_id
			t.string :provider
			t.string :uid
			t.timestamps
		end

		add_index :odania_user_authentications, [:user_id, :provider], name: 'omniauth_authentications_user_id_provider'
		add_index :odania_user_authentications, [:provider, :uid], name: 'omniauth_authentications_provider_uid'
	end
end
