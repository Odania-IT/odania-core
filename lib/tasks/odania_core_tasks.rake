namespace :odania do
	desc 'Set default page'
	task :set_default_page => :environment do
		domain = ENV['domain']
		subdomain = ENV['subdomain']

		# Check if parameter host is present
		if domain.blank?
			puts 'Please set a host name, e.g. domain=odania.com subdomain=www'
		else
			site = Odania::Site.where(domain: domain, subdomain: subdomain).first

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
		domain = ENV['domain']
		subdomain = ENV['subdomain']

		# Check if parameter host is present
		if domain.blank?
			puts 'Please set a host name, e.g. domain=odania.com subdomain=www'
		else
			site = Odania::Site.where(domain: domain, subdomain: subdomain).first
			language = Odania::Language.first

			if language.nil?
				puts 'Create a language first'
			elsif site.nil?
				name = subdomain.blank? ? domain : "#{subdomain}.#{domain}"
				site = Odania::Site.create!(default_language_id: language.id, name: name, domain: domain, subdomain: subdomain,
													 is_default: (Odania::Site.count == 0), tracking_code: '')
				site.menus.create!(language_id: language.id)
				puts "Site #{site.host} created!"
			else
				puts "Site #{site.host} already exists!"
			end
		end
	end

	desc 'Add a language'
	task :add_language => :environment do
		name = ENV['name']
		iso_639_1 = ENV['iso_639_1']

		if name.blank? or iso_639_1.blank?
			puts 'Please specify iso_639_1 and name, e.g. iso_639_1=de name=German'
		else
			language = Odania::Language.where(iso_639_1: iso_639_1).first
			if language.nil?
				language = Odania::Language.where(name: name).first
				if language.nil?
					Odania::Language.create!(name: name, iso_639_1: iso_639_1)
				else
					puts 'name already exists'
				end
			else
				puts 'iso_639_1 already exists'
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
