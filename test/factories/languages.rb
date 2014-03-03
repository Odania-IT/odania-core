# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :language, class: Odania::Language do
		sequence(:name) { |n| "Language#{n}" }
		sequence(:iso_639_1) { |n| "short#{n}" }
	end
end
