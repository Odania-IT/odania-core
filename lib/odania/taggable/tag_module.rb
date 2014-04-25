module Odania
	module Taggable
		module TagModule
			def update_tags(prev_tags, cur_tags, context)
				prev_tags = prev_tags.nil? ? [] : prev_tags.split(',')
				cur_tags = cur_tags.split(',')
				if prev_tags != cur_tags
					# Remove old tags
					removed = prev_tags - cur_tags
					removed.each do |tag|
						tag = Odania::Tag.where(name: tag, site_id: self.site_id, language_id: self.language_id).first
						unless tag.nil?
							xref = Odania::TagXref.where(tag_id: tag.id, ref: self, context: context).first
							xref.destroy unless xref.nil?
						end
					end

					# Add new tags
					new_tags = cur_tags - prev_tags
					new_tags.each do |tag|
						odania_tag = Odania::Tag.where(name: tag, site_id: self.site_id, language_id: self.language_id).first
						odania_tag = Odania::Tag.create(name: tag, site_id: self.site_id, language_id: self.language_id) if odania_tag.nil?
						Odania::TagXref.create(tag_id: odania_tag.id, ref: self, context: context)
					end
				end
			end
		end
	end
end
