module Odania
	module CoreTargetTypeUtil
		class << self
			# URL redirect
			def validate_url(target_data)
				return 'invalid target url' if target_data['url'].empty?
				begin
					!!URI.parse(target_data['url'])
				rescue URI::InvalidURIError
					return 'invalid target url'
				end
				return nil
			end

			def render_url(target_data, site, subpart)
				{redirect: target_data['url']}
			end

			# Content list
			def validate_content_list(target_data)
				return nil
			end

			def render_content_list(target_data, site, subpart)
				unless subpart.nil?
					odania_content = site.contents.where(id: subpart.to_i).first
					return {render_partial: 'odania/contents/show', locals: {odania_content: odania_content}} unless odania_content.nil?
				end

				odania_contents = site.contents.order('created_at DESC')
				return {render_partial: 'odania/contents/index', locals: {odania_contents: odania_contents}}
			end

			# Single content page
			def validate_content_id(target_data)
				return 'invalid content id' if target_data['id'].nil?

				content = Odania::Content.where(id: target_data['id']).first
				return 'invalid content id' if content.nil?
				return nil
			end

			def render_content(target_data, site, subpart)
				odania_content = site.contents.where(id: target_data['id']).first
				return {render_partial: 'odania/contents/show', locals: {odania_content: odania_content}} unless odania_content.nil?
				return {error: 'content not found'}
			end
		end
	end
end
