FactoryGirl.define do
	factory :user_device, :class => 'Odania::UserDevice' do
		user
		platform 'Android'
		uuid '1234567890'
		model 'Samsung Galaxy S4'
		version '4.2'
		token {SecureRandom.hex(64)}
	end

end
