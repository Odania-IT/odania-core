module OdaniaCore
	class Site < ActiveRecord::Base
		belongs_to :language

		scope :active, -> { where(is_active: true) }

		def self.get_site(host)
			Site.active.where(host: host).first
		end
	end
end
