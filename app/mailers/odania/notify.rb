class Odania::Notify < ActionMailer::Base
	def contact_form(site, data)
		@data = data
		@site = site
		mail(to: site.notify_email_address, subject: "Contact form: #{data['contact_name']} (#{site.name})", from: site.default_from_email)
	end

	def notify_admin(site, msg)
		@msg = msg
		@site = site
		mail(to: site.notify_email_address, subject: "[AdminNotify]: #{msg} (#{site.name})", from: site.default_from_email)
	end
end
