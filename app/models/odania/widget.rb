class Odania::Widget < ActiveRecord::Base
	belongs_to :site

	serialize :content, Hash
end
