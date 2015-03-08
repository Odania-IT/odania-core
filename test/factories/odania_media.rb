FactoryGirl.define do
	factory :odania_medium, :class => 'Odania::Media' do
		title "MyString"
		site
		language
		user
		is_global false
	end

end
