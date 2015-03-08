class AddCategoryToContent < ActiveRecord::Migration
	def change
		add_column :odania_contents, :category_id, :integer
	end
end
