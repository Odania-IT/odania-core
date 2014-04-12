# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :content, :class => 'Odania::Content' do
		sequence(:title) { |n| "Site #{n}" }
		sequence(:body) { |n| "Site Long Text #{n} #T1" }
		sequence(:body_short) { |n| "Site Short Text #{n}" }
		clicks 1
		views 1
		published_at "2014-02-12 21:54:11"
		is_active true
		site
		language
		user
	end
end
