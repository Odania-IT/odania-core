class Odania::InfoController < ApplicationController
	before_action :valid_site!
	before_filter :valid_menu!

	def imprint
	end

	def terms_and_conditions
	end

	def contact
		set_post_name
	end

	def contact_send
		set_post_name

		return redirect_to :action => 'index' if params[@contact_post_name].nil?

		# Send Mail
		Odania::Notify.contact_form(current_site, params[@contact_post_name]).deliver!

		# Remove cookie
		cookies[:contact_post_name] = nil
	end

	private

	def set_post_name
		if cookies[:contact_post_name].nil? or cookies[:contact_post_name].empty?
			cookies[:contact_post_name] = 'contact'+rand(100000).to_s
		end

		@contact_post_name = cookies[:contact_post_name]
	end
end
