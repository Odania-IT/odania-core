module Odania
	module Taggable
		module Core
			def self.included(base)
				base.send :include, Odania::Taggable::Core::InstanceMethods
				base.extend Odania::Taggable::Core::ClassMethods

				base.class_eval do
					after_save :save_tags
				end

				base.initialize_acts_as_taggable_on_core
			end

			module ClassMethods

				def initialize_acts_as_taggable_on_core
					include taggable_mixin
					tag_types.map(&:to_s).each do |tags_type|
						tag_type = tags_type.to_s.singularize

						taggable_mixin.class_eval <<-RUBY, __FILE__, __LINE__ + 1
							def #{tag_type}_list
								tag_list_on('#{tags_type}')
							end

							def #{tag_type}_list=(new_tags)
								set_tag_list_on('#{tags_type}', new_tags)
							end
						RUBY
					end
				end

				def is_taggable?
					true
				end

				def taggable_mixin
					@taggable_mixin ||= Module.new
				end
			end

			module InstanceMethods
				include Odania::Taggable::TagModule

				def is_taggable?
					self.class.is_taggable?
				end

				def set_tag_list_on(context, new_list)
					variable_name = "@#{context.to_s.singularize}_list"
					if new_list != tag_list_on(context)
						old_variable_name = "@#{context.to_s.singularize}_list_old"
						instance_variable_set(old_variable_name, tag_list_on(context))
					end
					instance_variable_set(variable_name, new_list)
				end

				def tag_list_on(context)
					variable_name = "@#{context.to_s.singularize}_list"
					instance_variable_get(variable_name)
				end

				def tag_counts_on(context)

				end

				def save_tags
					tag_types.map(&:to_s).each do |tags_type|
						new_tags = tag_list_on(tags_type)
						old_variable_name = "@#{tags_type.to_s.singularize}_list_old"
						old_tags = instance_variable_get(old_variable_name)

						update_tags(old_tags, new_tags, tags_type)
					end

					true
				end
			end
		end
	end
end
