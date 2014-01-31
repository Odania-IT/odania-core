# These is a workaround to test the functionality in a "normal way". It still feels a bit hacky and there might be a better way to test it.
class TestController < ApplicationController
	before_filter :authenticate_user!, only: [:test_authorized]
	before_filter :valid_site!, only: [:test_valid_site]

	def test_signed_in
		render :text => user_signed_in?
	end

	def test_current_user
		render :text => current_user
	end

	def test_authorized
		render :text => 'ok'
	end

	def test_current_site
		render :text => current_site.to_json(only: ['host', 'is_active'])
	end

	def test_valid_site
		render :text => 'ok'
	end
end
