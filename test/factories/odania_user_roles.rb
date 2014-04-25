# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user_role, :class => 'Odania::UserRole' do
		user
		role 1
	end
end
