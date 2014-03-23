module Odania
	module TagModule
		def update_tags(prev_tags, cur_tags)
			prev_tags = prev_tags.split(',')
			cur_tags = cur_tags.split(',')
			if prev_tags != cur_tags
				# Remove old tags
				removed = prev_tags - cur_tags
				removed.each do |tag|
					tag = Odania::Tag.where(name: tag).first
					unless tag.nil?
						xref = Odania::TagXref.where(tag_id: tag.id, ref: self).first
						xref.destroy unless xref.nil?
					end
				end

				# Add new tags
				new_tags = cur_tags - prev_tags
				new_tags.each do |tag|
					odania_tag = Odania::Tag.where(name: tag).first
					odania_tag = Odania::Tag.create(name: tag) if odania_tag.nil?
					Odania::TagXref.create(tag_id: odania_tag.id, ref: self)
				end
			end
		end
	end
end
