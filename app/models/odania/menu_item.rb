class Odania::MenuItem < ActiveRecord::Base
	serialize :target_data

	belongs_to :parent, class_name: 'Odania::MenuItem', touch: true
	belongs_to :menu, class_name: 'Odania::Menu', touch: true

	validates_presence_of :title, minimum: 1
	validates_uniqueness_of :title, scope: [:menu_id, :parent_id]
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

	before_create do
		# Find next position
		menu_item = self.menu.menu_items.where(parent_id: self.parent_id).order('position DESC').first
		self.position = menu_item.nil? ? 1 : menu_item.position + 1

		true
	end
end
