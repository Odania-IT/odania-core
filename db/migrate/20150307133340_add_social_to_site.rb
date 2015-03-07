class AddSocialToSite < ActiveRecord::Migration
	def change
		add_column :odania_sites, :social, :text
	end
end
