FactoryGirl.define do
	factory :static_page, :class => 'Odania::StaticPage' do
		title 'MyString'
		body 'MyText'
		clicks 1
		views 1
		site
		language
		user
	end

end
