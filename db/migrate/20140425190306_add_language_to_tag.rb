class AddLanguageToTag < ActiveRecord::Migration
	def change
		add_column :odania_tags, :language_id, :integer
	end
end
