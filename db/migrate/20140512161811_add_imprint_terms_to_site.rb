class AddImprintTermsToSite < ActiveRecord::Migration
	def change
		add_column :odania_sites, :imprint, :text
		add_column :odania_sites, :terms_and_conditions, :text
	end
end
