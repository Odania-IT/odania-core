class CreateOdaniaCategoryXrefs < ActiveRecord::Migration
	def change
		create_table :odania_category_xrefs do |t|
			t.references :ref, polymorphic: true, index: true
			t.references :category, index: true
			t.timestamps null: false
		end

		add_foreign_key :odania_category_xrefs, :odania_categories, column: :category_id
	end
end
