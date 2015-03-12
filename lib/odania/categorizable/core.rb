module Odania
	module Categorizable
		module Core
			def self.included(base)
				base.send :include, Odania::Categorizable::Core::InstanceMethods
				base.extend Odania::Categorizable::Core::ClassMethods

				base.class_eval do
					after_save :save_categories
				end
			end

			module ClassMethods

				def is_categorizable?
					true
				end
			end

			module InstanceMethods
				include Odania::Categorizable::CategoryModule

				def is_categorizable?
					self.class.is_categorizable?
				end

				def category_list=(new_list)
					@category_list_old = category_list if new_list != category_list
					@category_list = new_list
				end

				def category_list
					@category_list.nil? ? '' : @category_list
				end

				def save_categories
					update_categories(@category_list_old, category_list)

					true
				end
			end
		end
	end
end
