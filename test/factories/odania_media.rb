FactoryGirl.define do
	factory :odania_medium, :class => 'Odania::Media' do
		title  { FFaker::Movie.simple_title }
		site
		language
		user
		is_global false
	end

end
