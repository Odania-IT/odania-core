# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :content, :class => 'Odania::Content' do
		sequence(:title) { |n| "Content #{n}" }
		sequence(:body) { |n| "Content Long Text #{n} #T1" }
		sequence(:body_short) { |n| "Content Short Text #{n}" }
		clicks 1
		views 1
		published_at '2014-02-12 21:54:11'
		state 'PUBLISHED'
		site
		language
		user
	end
end
