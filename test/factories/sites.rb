# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :site, class: Odania::Site do
		sequence(:name) { |n| "Site #{n}" }
		sequence(:domain) { |n| "domain#{n}.com" }
		subdomain 'www'
		is_active true
		is_default false
		sequence(:tracking_code) { |n| "TRACKING CODE #{n}" }
		sequence(:description) { |n| "Site Description #{n}" }
		default_language

		host { "#{self.subdomain}.#{self.domain}" }
	end

	factory :default_site, class: Odania::Site do
		name 'Default Site'
		domain 'test.host'
		subdomain nil
		is_active true
		is_default true
		tracking_code 'TRACKING CODE'
		description 'Default Site Description'
		default_language

		host { "#{self.subdomain}.#{self.domain}" }
	end

	factory :redirect_site, class: Odania::Site do
		name 'RedirectSite'
		domain 'redirect.host'
		subdomain nil
		association :redirect_to, factory: :site
		default_language

		host { "#{self.subdomain}.#{self.domain}" }
	end
end
