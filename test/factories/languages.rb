# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :language, class: Odania::Language do
		sequence(:name) { |n| "Language#{n}" }
		sequence(:iso_639_1) { |n| "short#{n}" }
	end

	factory :default_language, class: Odania::Language do
		name 'German'
		iso_639_1 'de'
		initialize_with { Odania::Language.find_or_create_by(iso_639_1: iso_639_1)}
	end
end
