class Odania::StaticPage < ActiveRecord::Base
	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	belongs_to :user, :class_name => 'Odania::User'
	belongs_to :widget, class_name: 'Odania::Widget'

	validates_length_of :title, minimum: 1
	validates_length_of :body, minimum: 10
	validates_presence_of :language_id, :site_id, :user_id
	validate :validate_widget

	def to_param
		"#{self.id}-#{self.title.parameterize}"
	end

	def validate_widget
		if !self.widget_id.nil? and !self.site_id.eql?(self.widget.site_id)
			errors.add(:widget_id, 'invalid widget')
		end
	end
end
