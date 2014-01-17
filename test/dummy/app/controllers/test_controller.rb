class TestController < ApplicationController
  before_filter :authenticate_user!, only: [:test_authorized]

	def test_signed_in
		render :text => user_signed_in?
	end

	def test_current_user
		render :text => current_user
  end

  def test_authorized
    render :text => 'ok'
  end
end
