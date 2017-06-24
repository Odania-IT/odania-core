require 'test_helper'

module Odania
	class CategoriesControllerTest < ActionDispatch::IntegrationTest
		include Engine.routes.url_helpers

		test 'should get index' do
			get categories_url(locale: 'de')
			assert_response :success
		end

		test 'should get show' do
			get categories_url(locale: 'de', id: category.id)
			assert_response :success
		end

	end
end
