class Odania::Widget < ActiveRecord::Base
	belongs_to :site, inverse_of: :default_widget
	belongs_to :content

	serialize :content, Hash
end
