class CreatePages < ActiveRecord::Migration[5.0]
	def change
		create_table :pages do |t|
			t.string :domain
			t.string :subdomain
			t.string :category
			t.string :url
			t.string :group_name
			t.string :plugin_url
			t.timestamps
		end

		add_index :pages, [:domain, :subdomain, :category]
	end
end
