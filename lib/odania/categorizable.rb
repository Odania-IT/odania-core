# Thanks to https://github.com/mbleigh/acts-as-taggable-on
module Odania
	module Categorizable
		autoload :Core, 'odania/categorizable/core'
		autoload :CategoryModule, 'odania/categorizable/category_module'
		autoload :CategoryCount, 'odania/categorizable/category_count'

		def categorizable?
			false
		end

		def acts_as_categorizable
			categorizable_on(:categories)
		end

		private

		def categorizable_on(*category_types)
			if categorizable?
				self.category_types = (self.category_types + category_types).uniq
			else
				category_types = category_types.to_a.flatten.compact.map(&:to_sym)
				class_attribute :category_types
				self.category_types = category_types

				class_eval do
					has_many :category_xrefs, :as => :ref, :dependent => :destroy, :class_name => 'Odania::CategoryXref'
					has_many :categories, :through => :category_xrefs, :source => :category, :class_name => 'Odania::Category'

					def self.categorizable?
						true
					end
				end
			end

			include Odania::Categorizable::Core
		end
	end
end
