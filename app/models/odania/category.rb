class Odania::Category < ActiveRecord::Base
	belongs_to :site, :class_name => 'Odania::Site', touch: true
	belongs_to :language, :class_name => 'Odania::Language', touch: true
	belongs_to :user, :class_name => 'Odania::User', touch: true
	has_many :category_xrefs, :class_name => 'Odania::CategoryXref'

	validates_length_of :title, minimum: 1
	validates_uniqueness_of :title, scope: [:site_id, :language_id]

	def to_param
		"#{self.id}-#{self.title.parameterize}"
	end

	before_create do
		self.count = 0 if self.count.nil?

		true
	end
end
