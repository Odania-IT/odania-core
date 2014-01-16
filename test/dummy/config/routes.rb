Rails.application.routes.draw do
	get '/test/test_signed_in' => 'test#test_signed_in'
	get '/test/test_current_user' => 'test#test_current_user'

	mount OdaniaCore::Engine => "/odania_core"
end
