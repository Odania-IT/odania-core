# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user, :class => 'Odania::User' do
		sequence(:name) { |n| "User#{n}" }
	end
end
