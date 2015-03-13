class AddFieldsToSite < ActiveRecord::Migration
	def change
		add_column :odania_sites, :title, :string
		add_column :odania_sites, :meta_keywords, :string
		add_column :odania_sites, :additional_parameters, :text
	end
end
