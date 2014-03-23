require 'test_helper'
require 'odania/filter'

class TestObj
	attr_accessor :id

	def initialize(id)
		self.id = id
	end
end

class Odania::FilterTest < ActiveSupport::TestCase
	test 'test only links are changed' do
		obj = {id: '123'}
		input = '<p>Test</p>'
		tags, result = Odania::Filter.filter_html(obj, input)

		assert_equal input, result
	end

	test 'test link is changed' do
		Rails.application.routes.default_url_options[:host] = 'test.host'
		obj = TestObj.new(id: '123')
		input = '<p><a href="http://target.de">Test</a></p>'
		tags, result = Odania::Filter.filter_html(obj, input)

		assert_match /http:\/\/test.host\/deliver\/click/, result
		assert_match /target\.de/, result
	end

	test 'test tags are replaces' do
		obj = {id: '123'}
		input = '<p>Test #Tag1 #Tag2  asdsda #Tgf-4</p>'
		tags, result = Odania::Filter.filter_html(obj, input)

		assert_equal 'Tag1,Tag2,Tgf-4', tags
		assert_equal "<p>Test <a href=\"/tags/tag1\">Tag1</a> <a href=\"/tags/tag2\">Tag2</a>  asdsda <a href=\"/tags/tgf-4\">Tgf-4</a></p>", result
	end
end
