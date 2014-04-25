module Odania
	module CoreTargetTypeUtil
		class << self
			# URL redirect
			def validate_url(menu_item, target_data)
				return 'invalid target url' if target_data['url'].nil? or target_data['url'].empty?
				begin
					!!URI.parse(target_data['url'])
				rescue URI::InvalidURIError
					return 'invalid target url'
				end

				menu_item.full_path = ''
				menu_item.full_path = menu_item.parent.full_path+'/' unless menu_item.parent_id.nil?
				menu_item.full_path += menu_item.title.parameterize

				return nil
			end

			def render_url(menu_item, site, subpart)
				{redirect: menu_item.target_data['url']}
			end

			# Content list
			def validate_content_list(menu_item, target_data)
				menu_item.full_path = 'contents'

				unless target_data['tag'].nil? or target_data['tag'].blank?
					menu_item.full_path = "contents?tag=#{target_data['tag']}"
				end

				return nil
			end

			# Single content page
			def validate_content_id(menu_item, target_data)
				return 'invalid content id' if target_data['id'].nil?

				content = Odania::Content.where(id: target_data['id']).first
				return 'invalid content id' if content.nil?

				menu_item.full_path = "contents/#{content.to_param}"

				return nil
			end
		end
	end
end
