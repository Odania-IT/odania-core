FactoryGirl.define do
	factory :odania_category_xref, :class => 'Odania::CategoryXref' do
		association :ref, factory: :content
		category
	end

end
