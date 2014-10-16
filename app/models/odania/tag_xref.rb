class Odania::TagXref < ActiveRecord::Base
	belongs_to :tag, class_name: 'Odania::Tag'
	belongs_to :ref, polymorphic: true

	validates_presence_of :context
	validates_presence_of :tag_id
	validates_uniqueness_of :tag_id, :scope => [:ref_type, :ref_id, :context]

	after_destroy do
		unless self.tag.nil?
			tag.count = tag.tag_xrefs.count
			if tag.count.zero?
				tag.destroy
			else
				tag.save!
			end
		end
	end

	after_create do
		tag.count = tag.tag_xrefs.count
		tag.save!
	end
end
