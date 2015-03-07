class ConvertHostToDomainSubdomain < ActiveRecord::Migration
	def up
		Odania::Site.transaction do
			add_column :odania_sites, :domain, :string
			add_column :odania_sites, :subdomain, :string

			Odania::Site.all.each do |site|
				split = site.host.split('.')
				site.domain = split.slice!(-2, 2).join('.')
				site.subdomain = split.join('.')
				site.save!
			end
		end
	end

	def down
		remove_column :odania_sites, :domain
		remove_column :odania_sites, :subdomain
	end
end
