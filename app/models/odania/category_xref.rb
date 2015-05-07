class Odania::CategoryXref < ActiveRecord::Base
	belongs_to :ref, polymorphic: true, touch: true
	belongs_to :category

	validates_presence_of :category_id
	validates_uniqueness_of :category_id, :scope => [:ref_type, :ref_id]

	after_destroy do
		unless self.category.nil?
			category.count = category.category_xrefs.count
			category.save!
		end
	end

	after_create do
		category.count = category.category_xrefs.count
		category.save!
	end
end
