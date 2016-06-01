config = YAML.load_file File.join(Rails.root, 'config', 'elasticsearch.yml')
$elasticsearch = Elasticsearch::Client.new log: true, hosts: config[Rails.env]['hosts']
