class CreateSites < ActiveRecord::Migration
	def change
		create_table :odania_sites do |t|
			t.string :name
			t.string :host
			t.string :title
			t.boolean :is_active
			t.boolean :is_default
			t.text :tracking_code
			t.text :description
			t.text :meta
			t.text :additional_parameters
			t.string :template
			t.boolean :user_signup_allowed, default: false
			t.integer :default_language_id
			t.integer :redirect_to_id
		end

		add_index :odania_sites, [:host], unique: true
	end
end
