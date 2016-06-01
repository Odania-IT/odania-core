class Entry
	include Elasticsearch::Persistence::Model

	attribute :domain, String, default: nil, mapping: { type: 'string' }
	attribute :subdomain, String, default: nil, mapping: { type: 'string' }
	attribute :category, String, default: nil, mapping: { type: 'string' }
	attribute :path, String, default: nil, mapping: { type: 'string' }
	attribute :full_domain, String, default: nil, mapping: { type: 'string' }
	attribute :full_path, String, default: nil, mapping: { type: 'string' }
	attribute :content, String, default: nil, mapping: { type: 'string' }
	attribute :url,  Integer, default: 0, mapping: { type: 'integer' }

	validates :title, presence: true
end
