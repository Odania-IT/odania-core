module Odania
	module TargetType
		mattr_reader :targets
		@@targets = Hash.new
		@@targets['CONTENT'] = {type: 'CONTENT', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_content_id',
										render_func: 'render_content', selector: 'admin/odania/contents/choose_content',
										add_id_to_url: false}
		@@targets['CONTENT_LIST'] = {type: 'CONTENT_LIST', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_content_list',
											  render_func: 'render_content_list', selector: 'admin/odania/contents/choose_content_list',
											  add_id_to_url: true}
		@@targets['URL'] = {type: 'URL', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_url',
								  render_func: 'render_url', selector: 'admin/odania/menu_items/choose_url',
								  add_id_to_url: false}

		class << self
			def get_target(menu_item, site, subpart)
				target_info = self.targets[menu_item.target_type]
				return nil if target_info.nil?

				m = target_info[:module].constantize
				return m.send(target_info[:render_func], menu_item, site, subpart) if m.respond_to?(target_info[:render_func])
				return nil
			end

			def validate_data(menu_item, target_type, target_data)
				return 'invalid target_data' if target_data.nil?

				target_info = self.targets[target_type]
				return 'invalid target_type' if target_info.nil?

				m = target_info[:module].constantize
				return m.send(target_info[:validator_func], menu_item, target_data) if m.respond_to?(target_info[:validator_func])

				return nil
			end

			def get_link_for_obj(obj)
				menu_item = obj.menu_item
				target_info = self.targets[menu_item.target_type]
				return if target_info.nil?

				url = "#{obj.menu_item.get_target_path}"
				url += "/#{obj.to_param}" if target_info[:add_id_to_url]
				return url
			end
		end
	end
end
