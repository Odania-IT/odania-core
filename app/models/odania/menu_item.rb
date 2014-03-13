class Odania::MenuItem < ActiveRecord::Base
	serialize :target_data

	belongs_to :parent, class_name: 'Odania::MenuItem'
	belongs_to :menu, class_name: 'Odania::Menu'

	validates_presence_of :title, minimum: 1
end
