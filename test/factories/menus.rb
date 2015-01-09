# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :menu, :class => 'Odania::Menu' do
		site
		language
		published true

		factory :menu_with_items do
			# Default value for amount of items
			transient do
				amount 5
			end

			after(:create) do |menu, evaluator|
				create_list(:menu_item, evaluator.amount, menu: menu)
			end
		end
	end
end
