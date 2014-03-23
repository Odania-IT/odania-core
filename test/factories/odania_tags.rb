# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :odania_tag, :class => 'Odania::Tag' do
    name "MyString"
    count 1
  end
end
