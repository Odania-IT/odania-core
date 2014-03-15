class Odania::MenuItem < ActiveRecord::Base
	serialize :target_data

	belongs_to :parent, class_name: 'Odania::MenuItem'
	belongs_to :menu, class_name: 'Odania::Menu'

	validates_presence_of :title, minimum: 1
	validate :validate_target

	attr_accessor :target_data_url, :target_data_id, :target_data_type

	def validate_target
		unless Odania::TargetType::TARGETS.include?(self.target_type)
			errors.add(:target_type, 'invalid target_type')
		end

		self.target_data = Odania::TargetType.get_target_data(self.target_type, self)
		error_msg = Odania::TargetType.validate_data(self.target_type, self.target_data)
		unless error_msg.nil?
			errors.add(:target_type, error_msg)
		end
	end
end
