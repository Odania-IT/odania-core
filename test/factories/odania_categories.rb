FactoryGirl.define do
	factory :odania_category, :class => 'Odania::Category' do
		site
		user
		language
		title "MyString"
		count 1
	end

end
