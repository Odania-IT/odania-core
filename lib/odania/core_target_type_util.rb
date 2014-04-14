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
				return nil
			end

			def render_url(menu_item, site, subpart)
				{redirect: menu_item.target_data['url']}
			end

			# Content list
			def validate_content_list(menu_item, target_data)
				return nil
			end

			def render_content_list(menu_item, site, subpart)
				unless subpart.nil?
					odania_content = site.contents.where(id: subpart.to_i).first
					return {redirect: odania_content.menu_item.get_target_path} if !menu_item.id.eql?(odania_content.menu_item_id) and !odania_content.menu_item_id.nil?
					return {render_partial: 'odania/contents/show', locals: {odania_content: odania_content}} unless odania_content.nil?
				end

				odania_contents = site.contents.where(language_id: menu_item.menu.language_id).order('created_at DESC')
				return {render_partial: 'odania/contents/index', locals: {odania_contents: odania_contents}}
			end

			# Single content page
			def validate_content_id(menu_item, target_data)
				return 'invalid content id' if target_data['id'].nil?

				content = Odania::Content.where(id: target_data['id']).first
				return 'invalid content id' if content.nil?

				Odania::Content.where(menu_item_id: menu_item.id).update_all(menu_item_id: nil)
				content.menu_item_id = menu_item.id
				content.save!

				return nil
			end

			def render_content(menu_item, site, subpart)
				odania_content = site.contents.where(id: menu_item.target_data['id']).first
				return {redirect: odania_content.menu_item.get_target_path} unless menu_item.id.eql? odania_content.menu_item_id
				return {render_partial: 'odania/contents/show', locals: {odania_content: odania_content}} unless odania_content.nil?
				return {error: 'content not found'}
			end

			# Content list for tag
			def validate_content_list_for_tag(menu_item, target_data)
				return 'invalid tag' if target_data['tag'].nil? or target_data['tag'].blank?

				return nil
			end

			def render_content_list_for_tag(menu_item, site, subpart)
				odania_tag = Odania::Tag.where(name: menu_item.target_data['tag']).first
				return {} if odania_tag.nil?

				unless subpart.nil?
					odania_content = site.contents.joins(:tags).where(odania_tag_xrefs: {tag_id: odania_tag.id}).where(id: subpart.to_i).first
					return {error: 'content not found'} if odania_content.nil?
					return {redirect: odania_content.menu_item.get_target_path} if !menu_item.id.eql?(odania_content.menu_item_id) and !odania_content.menu_item_id.nil?
					return {render_partial: 'odania/contents/show', locals: {odania_content: odania_content}} unless odania_content.nil?
				end

				# Load all contents tagged with the tag
				odania_contents = site.contents.joins(:tags).where(language_id: menu_item.menu.language_id).
					where(odania_tag_xrefs: {tag_id: odania_tag.id}).order('created_at DESC')
				return {render_partial: 'odania/contents/index', locals: {odania_contents: odania_contents}}
			end
		end
	end
end
