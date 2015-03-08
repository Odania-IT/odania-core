class CreateOdaniaCategoryXrefs < ActiveRecord::Migration
	def change
		create_table :odania_category_xrefs do |t|
			t.references :ref, polymorphic: true, index: true
			t.references :category, index: true
			t.timestamps null: false
		end

		add_foreign_key :odania_category_xrefs, :refs
		add_foreign_key :odania_category_xrefs, :categories

		add_index :odania_category_xrefs, [:category_id]
		add_index :odania_category_xrefs, [:ref_type, :ref_id]
	end
end
