class AddLanguageIdToUser < ActiveRecord::Migration
	def change
		add_column :odania_users, :language_id, :integer
	end
end
