require 'test_helper'
require 'odania/filter'

class TestObj
	attr_accessor :id

	def initialize(id)
		self.id = id
	end

	def language
		return Odania::Language.new(iso_639_1: 'mp')
	end
end

class Odania::FilterTest < ActiveSupport::TestCase
	test 'test only links are changed' do
		obj = {id: '123'}
		input = '<p>Test</p>'
		result = Odania::Filter.filter_html(obj, input, 'http://test.host')

		assert_equal input, result
	end

	test 'test link is changed' do
		obj = TestObj.new(id: '123')
		input = '<p><a href="http://target.de">Test</a></p>'
		result = Odania::Filter.filter_html(obj, input, 'http://test.host')

		assert_match /http:\/\/test.host\/deliver\/click/, result
		assert_match /target\.de/, result
	end
end
