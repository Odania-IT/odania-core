namespace :odania do
	namespace :haproxy do
		desc 'Generate internal haproxy config'
		task :internal do

			class GenerateHaproxyCfg
				attr_accessor :plugins, :template

				def initialize(plugins)
					self.plugins = plugins
					self.template = File.new(File.join(File.dirname(__FILE__), '..', '..', 'templates', 'haproxy', 'haproxy.cfg.erb')).read
				end

				def render
					Erubis::Eruby.new(self.template).result(binding)
				end

				def write(out_dir)
					File.write("#{out_dir}/haproxy.cfg", self.render)
				end
			end

			plugins = {}

			Odania.plugin.get_all.each_pair do |service_name, instances|
				data = {}
				instances.each do |instance|
					next if instance.ServiceAddress.nil? or instance.ServiceAddress.empty?

					data[Odania.varnish_sanitize(instance.ServiceID)] = "#{instance.ServiceAddress}:#{instance.ServicePort}"
				end

				plugins[Odania.varnish_sanitize(service_name)] = data unless data.empty?
			end

			out_dir = '/etc/haproxy'
			GenerateHaproxyCfg.new(plugins).write out_dir

			# Reload haproxy
			data = <<EOF
#!/bin/bash
haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -db -sf $(pgrep -d ' ' haproxy)
EOF
			File.write('/etc/service/haproxy/run', data)
			`sv restart haproxy`
		end
	end
end
