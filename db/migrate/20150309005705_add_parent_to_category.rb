class AddParentToCategory < ActiveRecord::Migration
	def change
		add_column :odania_categories, :parent_id, :integer
		add_foreign_key :odania_categories, :odania_categories, column: :parent_id
	end
end
