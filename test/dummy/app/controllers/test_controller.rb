# These is a workaround to test the functionality in a "normal way". It still feels a bit hacky and there might be a better way to test it.
class TestController < ApplicationController
	before_action :authenticate_user!, only: [:test_authorized]
	before_action :valid_site!, only: [:test_valid_site]

	def test_signed_in
		render plain: user_signed_in?
	end

	def test_current_user
		render plain: current_user
	end

	def test_authorized
		render plain: 'ok'
	end

	def test_current_site
		render plain: current_site.to_json(only: ['host', 'is_active'])
	end

	def test_valid_site
		render plain: 'ok'
	end

	def test_view_helper
	end
end
