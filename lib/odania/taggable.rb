# Thanks to https://github.com/mbleigh/acts-as-taggable-on
module Odania
	module Taggable
		autoload :Core, 'odania/taggable/core'
		autoload :TagModule, 'odania/taggable/tag_module'
		autoload :TagCount, 'odania/taggable/tag_count'

		def taggable?
			false
		end

		def acts_as_taggable
			taggable_on(:tags)
		end

		private

		def taggable_on(*tag_types)
			if taggable?
				self.tag_types = (self.tag_types + tag_types).uniq
			else
				tag_types = tag_types.to_a.flatten.compact.map(&:to_sym)
				class_attribute :tag_types
				self.tag_types = tag_types

				class_eval do
					has_many :tag_xrefs, :as => :ref, :dependent => :destroy, :class_name => 'Odania::TagXref'
					has_many :tags, :through => :tag_xrefs, :source => :tag, :class_name => 'Odania::Tag'

					def self.taggable?
						true
					end
				end
			end

			include Odania::Taggable::Core
		end
	end
end
