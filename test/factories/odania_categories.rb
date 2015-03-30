FactoryGirl.define do
	factory :odania_category, :class => 'Odania::Category' do
		site
		user
		language
		title { FFaker::Movie.title }
		count 1
	end

end
