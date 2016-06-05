Rails.application.routes.draw do
	get 'home/index'

	get 'template/page'
	get 'template/content'
	get 'template/list_view'
	get 'template/error'
	get 'template/partial/:partial_name' => 'template#partial'

	get 'base/detect_language'
	get 'base/index'
	get 'base/identify'

	get 'health' => 'base#health'

	namespace :api do
		resources :web, except: [:new, :edit, :update] do
			collection do
				get 'by_id' => 'web#show'
			end
		end
		resources :partials, except: [:new, :edit, :update] do
			collection do
				get 'by_id' => 'partials#show'
			end
		end
		resources :layouts, except: [:new, :edit, :update] do
			collection do
				get 'by_id' => 'layouts#show'
			end
		end
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Serve websocket cable requests in-process
	# mount ActionCable.server => '/cable'
end
