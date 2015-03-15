# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :category, :class => 'Odania::Category' do
		sequence(:title) { |n| "Category #{n}" }
		site
		language
		user
	end
end
