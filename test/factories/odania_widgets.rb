# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :odania_widget, :class => 'Odania::Widget' do
    site_id 1
    template "MyString"
    name "MyString"
    content "MyText"
  end
end
