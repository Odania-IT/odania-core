namespace :odania do
	desc 'Register service at consul'
	task :register do
		# First check for a config in the docker volume
		settings = nil
		settings = YAML.load_file '/srv/config/settings.yml' if File.exist? '/srv/config/settings.yml'
		settings = YAML.load_file 'config/settings.yml' if settings.nil?
		domain = settings['config']['domain']
		subdomain = settings['config']['subdomain']

		plugin_config = JSON.parse File.read 'config/odania-config.json'
		plugin_config['domains'][domain] = {
			subdomain => plugin_config['domains']['ADMIN_DOMAIN']['ADMIN_SUB_DOMAIN']
		}
		plugin_config['domains'].delete('ADMIN_DOMAIN')

		ips = Odania.ips
		plugin_config['plugin-config']['ips'] = ips
		plugin_config['plugin-config']['ip'] = Odania.primary_ip(ips)
		plugin_config['plugin-config']['port'] = 9292
		plugin_config['plugin-config']['tags'] = ['core-backend']
		puts JSON.pretty_generate plugin_config

		plugin_instance_name = Odania.plugin.get_plugin_instance_name plugin_config['plugin-config']['name']
		Odania.plugin.register plugin_instance_name, plugin_config
	end

	namespace :global do
		desc 'Write global config to database'
		task :write_to_database => :environment do
			global_config = Odania.plugin.get_global_config

			global_config['domains'].each_pair do |domain, domain_data|
				domain_data.each_pair do |subdomain, data|
					%w(dynamic).each do |type|
						data[type].each_pair do |url, page_data|
							category = url.split('/')
							category.pop
							category = category.join('/')
							puts "D: #{domain} S: #{subdomain} U: #{url} T: #{type} C: #{category}"

							use_domain = '_general'.eql?(domain) ? nil : domain
							use_subdomain = '_general'.eql?(subdomain) ? nil : subdomain

							page = Entry.where(domain: use_domain, subdomain: use_subdomain, category: category).first
							page = Entry.new if page.nil?
							page.domain = use_domain
							page.subdomain = use_subdomain
							page.category = category
							page.group_name = page_data['group_name']
							page.plugin_url = page_data['plugin_url']
							page.url = url
							page.save!
						end
					end

				end
			end

		end
	end
end
