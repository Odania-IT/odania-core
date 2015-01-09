FactoryGirl.define do
	factory :click_tracking, :class => 'Odania::ClickTracking' do
		association :obj, factory: :content
		view_date Time.now
		referer 'http://www.planetech.de'
	end
end
