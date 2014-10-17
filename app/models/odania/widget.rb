class Odania::Widget < ActiveRecord::Base
	belongs_to :site, inverse_of: :default_widget

	serialize :content, Hash
end
