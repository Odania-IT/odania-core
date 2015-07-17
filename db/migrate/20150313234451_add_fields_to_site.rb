class AddFieldsToSite < ActiveRecord::Migration
	def change
		unless column_exists? :odania_sites, :title
			add_column :odania_sites, :title, :string
			Odania::Site.update_all('title = name')
		end
		unless column_exists? :odania_sites, :meta
			add_column :odania_sites, :meta, :text
			Odania::Site.update_all("meta = '{\"keywords\":\"\"}'")
		end
		unless column_exists? :odania_sites, :additional_parameters
			add_column :odania_sites, :additional_parameters, :text
			Odania::Site.update_all("additional_parameters = '{\"none\":\"\"}'")
		end
	end
end
