class Odania::MenuItem < ActiveRecord::Base
	serialize :target_data

	belongs_to :parent, class_name: 'Odania::MenuItem'
	belongs_to :menu, class_name: 'Odania::Menu'

	validates_presence_of :title, minimum: 1
	validate :validate_target

	def validate_target
		unless Odania::TargetType.targets.keys.include?(self.target_type)
			errors.add(:target_type, 'invalid target_type')
		end

		error_msg = Odania::TargetType.validate_data(self, self.target_type, self.target_data)
		unless error_msg.nil?
			errors.add(:target_type, error_msg)
		end
	end

	def get_target_path
		"#{self.menu.get_target_path}/#{self.full_path}"
	end

	before_save do
		# Build the full_path
		self.full_path = ''
		self.full_path = self.parent.full_path+'/' unless self.parent_id.nil?
		self.full_path += self.title.parameterize

		# Find next position
		menu_item = self.menu.menu_items.where(parent_id: self.parent_id).order('position DESC').first
		self.position = menu_item.nil? ? 1 : menu_item.position + 1

		return true
	end
end
