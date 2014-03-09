# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :site, class: Odania::Site do
		sequence(:name) { |n| "Site #{n}" }
		sequence(:host) { |n| "www.domain#{n}.com" }
		is_active true
		is_default false
		sequence(:tracking_code) { |n| "TRACKING CODE #{n}" }
		sequence(:description) { |n| "Site Description #{n}" }
		language
	end

	factory :default_site, class: Odania::Site do
		name 'Default Site'
		host 'test.host'
		is_active true
		is_default true
		tracking_code 'TRACKING CODE'
		description 'Default Site Description'
		language
	end

	factory :redirect_site, class: Odania::Site do
		name 'RedirectSite'
		host 'redirect.host'
		association :redirect_to, factory: :site
		language
	end
end
