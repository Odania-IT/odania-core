module Odania
	module TargetType
		INTERNAL = 'internal'
		URL = 'url'

		class << self
			def get_target(type, data)
				if Odania::TargetType::INTERNAL.eql? type
					return get_internal_url(data)
				elsif Odania::TargetType::URL.eql? type
					return data['url']
				end
			end

			def get_internal_url(data)
				obj = data['type'].constantize.where(id: data['id']).first
				return '/' if obj.nil?
				obj
			end
		end
	end
end
