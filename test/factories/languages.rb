# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence :language_sequence do |n|
		result = 'aa'
		n.times { result.succ! }
		result
	end

	factory :language, class: Odania::Language do
		sequence(:name) { |n| "Language#{n}" }
		iso_639_1 {generate :language_sequence}
	end

	factory :default_language, class: Odania::Language do
		name 'German'
		iso_639_1 'de'
		initialize_with { Odania::Language.find_or_create_by(iso_639_1: iso_639_1) }
	end
end
