# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user, :class => 'Odania::User' do
		sequence(:name) { |n| "User#{n}" }
		sequence(:email) { |n| "mail#{n}@example.com" }
		password '12345678'
		password_confirmation '12345678'
		confirmed_at { Time.now }

		after(:create) do |user, evaluator|
			create_list(:user_role, 1, user: user)
		end

		factory :default_user do
			id 1
			name 'Admin'
			email 'mail@example.com'
		end
	end
end
