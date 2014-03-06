namespace :odania do
	desc 'Set default page'
	task :set_default_page => :environment do
		host_name = ENV['host']

		# Check if parameter host is present
		if host_name.blank?
			puts 'Please set a host name, e.g. host=www.odania.com'
		else
			site = Odania::Site.where(host: host_name).first

			if site.is_default
				puts "Site #{site.host} already default!"
			else
				Odania::Site.update_all(is_default: false)
				site.is_default = true
				site.save!
				puts "Site #{site.host} set to default!"
			end
		end
	end

	desc 'Sets up the first domain'
	task :add_site => :environment do
		host_name = ENV['host']

		# Check if parameter host is present
		if host_name.blank?
			puts 'Please set a host name, e.g. host=www.odania.com'
		else
			site = Odania::Site.where(host: host_name).first
			language = Odania::Language.first

			if site.nil?
				site = Odania::Site.create!(language_id: language.id, :name => host_name, :host => host_name, :is_default => (Odania::Site.count == 0))
				puts "Site #{site.host} created!"
			else
				puts "Site #{site.host} already exists!"
			end
		end
	end

	namespace :db do
		desc 'Seed engine data'
		task :seed_core => :environment do
			OdaniaCore::Engine.load_seed
		end
	end
end
