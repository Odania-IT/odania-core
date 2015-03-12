module Odania
	module Categorizable
		module CategoryModule
			def update_categories(prev_categories, cur_categories)
				prev_categories = prev_categories.nil? ? [] : prev_categories.split(',')
				cur_categories = cur_categories.split(',')
				if prev_categories != cur_categories
					# Remove old categories
					removed = prev_categories - cur_categories
					removed.each do |category|
						category = Odania::Category.where(title: category, site_id: self.site_id, language_id: self.language_id).first
						unless category.nil?
							xref = Odania::CategoryXref.where(category_id: category.id, ref: self).first
							xref.destroy unless xref.nil?
						end
					end

					# Add new categories
					new_categories = cur_categories - prev_categories
					new_categories.each do |category|
						odania_category = Odania::Category.where(title: category, site_id: self.site_id, language_id: self.language_id).first
						odania_category = Odania::Category.create(title: category, site_id: self.site_id, language_id: self.language_id) if odania_category.nil?
						Odania::CategoryXref.create(category_id: odania_category.id, ref: self)
					end
				end
			end
		end
	end
end
