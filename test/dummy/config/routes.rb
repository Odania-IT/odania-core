Rails.application.routes.draw do
	get '/test/test_signed_in' => 'test#test_signed_in'
	get '/test/test_current_user' => 'test#test_current_user'
	get '/test/test_authorized' => 'test#test_authorized'
	get '/test/test_current_site' => 'test#test_current_site'
	get '/test/test_valid_site' => 'test#test_valid_site'
	get '/test/test_view_helper' => 'test#test_view_helper'
end
