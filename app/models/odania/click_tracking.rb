class Odania::ClickTracking < ActiveRecord::Base
	belongs_to :obj, polymorphic: true
end
