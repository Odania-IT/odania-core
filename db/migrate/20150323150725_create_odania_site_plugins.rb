class CreateOdaniaSitePlugins < ActiveRecord::Migration
	def change
		create_table :odania_site_plugins do |t|
			t.references :site, index: true
			t.string :plugin_name
			t.timestamps null: false
		end
		add_foreign_key :odania_site_plugins, :odania_sites, column: :site_id
	end
end
