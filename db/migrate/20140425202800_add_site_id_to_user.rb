class AddSiteIdToUser < ActiveRecord::Migration
	def change
		add_column :odania_users, :site_id, :integer
	end
end
