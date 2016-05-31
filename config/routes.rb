Rails.application.routes.draw do
	get 'home/index'

	namespace :admin do
		get 'consul' => 'consul#index'
		get 'consul/service'
		get 'consul/status'
		get 'domains' => 'domains#index'
		get 'config' => 'config#index'
		get 'preview' => 'preview#index'
		get 'preview/show'
	end
	get 'admin' => 'admin#index'

	get 'template/page'
	get 'template/content'
	get 'template/error'
	get 'template/partial/:partial_name' => 'template#partial'

	get 'base/detect_language'
	get 'base/index'
	get 'base/identify'

	get 'health' => 'base#health'

	namespace :api do
		resources :web, except: [:new, :edit]
		resources :partials, except: [:new, :edit]
		resources :layouts, except: [:new, :edit]
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Serve websocket cable requests in-process
	# mount ActionCable.server => '/cable'
end
