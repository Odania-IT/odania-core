class Odania::SitePlugin < ActiveRecord::Base
	belongs_to :site, class_name: 'Odania::Site'

	validates_presence_of :site_id
	validate :validate_plugin_name

	def validate_plugin_name
		unless Odania::Protected.plugins.include? self.plugin_name
			errors.add(:plugin_name, 'invalid plugin')
		end
	end
end
