module Odania
	module TargetType
		mattr_reader :targets
		@@targets = Hash.new
		@@targets['CONTENT'] = {type: 'CONTENT', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_content_id',
										  render_func: 'render_content', selector: 'admin/odania/contents/choose_content'}
		@@targets['CONTENT_LIST'] = {type: 'CONTENT_LIST', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_content_list',
										  render_func: 'render_content_list', selector: 'admin/odania/contents/choose_content_list'}
		@@targets['URL'] = {type: 'URL', module: 'Odania::CoreTargetTypeUtil', validator_func: 'validate_url',
								  render_func: 'render_url', selector: 'admin/odania/menu_items/choose_url'}

		class << self
			def get_target(type, data, site, subpart)
				target_info = self.targets[type]
				return nil if target_info.nil?

				m = target_info[:module].constantize
				return m.send(target_info[:render_func], data, site, subpart) if m.respond_to?(target_info[:render_func])
				return nil
			end

			def validate_data(target_type, target_data)
				return 'invalid target_data' if target_data.nil?

				target_info = self.targets[target_type]
				return 'invalid target_type' if target_info.nil?

				m = target_info[:module].constantize
				return m.send(target_info[:validator_func], target_data) if m.respond_to?(target_info[:validator_func])

				return nil
			end
		end
	end
end
