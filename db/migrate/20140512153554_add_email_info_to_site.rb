class AddEmailInfoToSite < ActiveRecord::Migration
	def change
		add_column :odania_sites, :default_from_email, :string
		add_column :odania_sites, :notify_email_address, :string
	end
end
