class Odania::Tag < ActiveRecord::Base
	has_many :tag_xrefs, :class_name => 'Odania::TagXref'
end
