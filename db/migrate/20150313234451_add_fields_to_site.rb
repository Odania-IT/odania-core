class AddFieldsToSite < ActiveRecord::Migration
	def change
		add_column :odania_sites, :title, :string
		add_column :odania_sites, :meta, :text
		add_column :odania_sites, :additional_parameters, :text

		Odania::Site.update_all('title = name')
		Odania::Site.update_all("additional_parameters = '{\"none\":\"\"}'")
		Odania::Site.update_all("meta = '{\"keywords\":\"\"}'")
	end
end
