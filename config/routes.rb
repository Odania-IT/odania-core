Rails.application.routes.draw do
	namespace :admin do
		get 'consul' => 'consul#index'
		get 'consul/service'
		get 'consul/status'
		get 'domains' => 'domains#index'
		get 'config' => 'config#index'
	end
	get 'admin' => 'admin#index'

	get 'template/page'
	get 'template/content'
	get 'template/partial/:partial_name' => 'template#partial'

	get 'base/detect_language'
	get 'base/index'

	get 'health' => 'base#health'

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Serve websocket cable requests in-process
	# mount ActionCable.server => '/cable'
end
