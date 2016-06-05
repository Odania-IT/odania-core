namespace :odania do
	desc 'Register service at consul'
	task :register do
		plugin_config = JSON.parse File.read 'config/odania-config.json'

		ips = Odania.ips
		plugin_config['plugin-config']['ips'] = ips
		plugin_config['plugin-config']['ip'] = Odania.primary_ip(ips)
		plugin_config['plugin-config']['port'] = 9292
		plugin_config['plugin-config']['tags'] = ['core-backend']
		puts JSON.pretty_generate plugin_config

		plugin_instance_name = Odania.plugin.get_plugin_instance_name plugin_config['plugin-config']['name']
		Odania.plugin.register plugin_instance_name, plugin_config
	end
end
