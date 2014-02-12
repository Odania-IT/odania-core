module OdaniaCore
	class Site
		include Mongoid::Document
		include Mongoid::Timestamps

		field :name, type: String
		field :host, type: String
		field :is_active, type: Mongoid::Boolean, default: true
		field :is_default, type: String, default: false
		field :tracking_code, type: String
		field :description, type: String

		belongs_to :language
		belongs_to :redirect_to, :class_name => 'OdaniaCore::Site'

		scope :active, -> { where(is_active: true) }

		def self.get_site(host)
			Site.active.where(host: host).first
		end
	end
end
