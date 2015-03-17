FactoryGirl.define do
	factory :odania_user_device, :class => 'Odania::UserDevice' do
		user
		platform 'Android'
		uuid '1234567890'
		model 'Samsung Galaxy S4'
		version '4.2'
	end

end
