class Odania::TagXref < ActiveRecord::Base
	belongs_to :tag, class_name: 'Odania::Tag'
	belongs_to :ref, polymorphic: true
end
