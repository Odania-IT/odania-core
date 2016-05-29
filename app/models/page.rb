class Page
	include Mongoid::Document

	field :domain, type: String
	field :subdomain, type: String
	field :category, type: String

	field :group_name, type: String
	field :plugin_url, type: String
	field :url, type: String

	index({ domain: 1, subdomain: 1, category: 1 }, {})
end
