# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :menu_item, :class => 'Odania::MenuItem' do
		sequence(:title) { |n| "title#{n}" }
		published true
		target_type Odania::TargetType::URL
		target_data {{'url' => 'http://target.url.de'}}
	end
end
