# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :language, class: OdaniaCore::Language do
		name "English"
		iso_639_1 "en"
	end
end
