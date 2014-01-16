class TestController < ApplicationController
	def test_signed_in
		render :text => user_signed_in?
	end

	def test_current_user
		render :text => current_user
	end
end
