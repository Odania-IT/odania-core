module Odania
	module TargetType
		INTERNAL = 'internal'
		URL = 'url'

		TARGETS = [URL, INTERNAL]

		class << self
			def get_target(type, data)
				if INTERNAL.eql? type
					return get_internal_url(data)
				elsif URL.eql? type
					return data['url']
				end
			end

			def get_internal_url(data)
				obj = data['type'].constantize.where(id: data['id']).first
				return '/' if obj.nil?
				obj
			end

			def validate_data(target_type, target_data)
				return 'invalid target_data' if target_data.nil?

				if URL.eql? target_type
					return 'invalid target url' if target_data['url'].nil?
				elsif INTERNAL.eql? target_type
					return 'invalid internal link' if target_data['id'].nil? or target_data['type'].nil?
				end

				return nil
			end

			def get_target_data(target_type, obj)
				if URL.eql? target_type
					return {'url' => obj.target_data_url}
				elsif INTERNAL.eql? target_type
					return {'id' => obj.target_data_id, 'type' => obj.target_data_type}
				end

				return {}
			end

			def set_from_target_data(obj)
				return if obj.target_data.nil?

				if URL.eql? obj.target_type
					obj.target_data_url = obj.target_data['url']
				elsif INTERNAL.eql? obj.target_type
					obj.target_data_id = obj.target_data['id']
					obj.target_data_type = obj.target_data['type']
				end
			end
		end
	end
end
