Rails.application.routes.draw do
	get 'tags' => 'tags#index'
	get 'tags/:tag' => 'tags#show', as: 'tag'
	mount Ckeditor::Engine => '/ckeditor'

	match '/deliver/click' => 'odania/deliver#click', via: [:get, :post], as: :deliver_click

	get '/imprint' => 'info#imprint'
	get '/contact' => 'info#contact'
	post '/contact' => 'info#contact_send'

	namespace :admin do
		namespace :odania do
			resources :contents
			resources :menus do
				resources :menu_items, controller: 'menu_items', as: 'odania_menu_items' do
					member do
						get :set_default
					end

					collection do
						post :select_odania_menu
					end
				end
			end
			get 'menu_items' => 'menu_items#overview'
			resources :sites
			resources :languages
		end
		get '/' => 'dashboard#index'
	end

	# Track views
	match 'track_view/:type/:id' => 'odania/statistics#track_view', :as => :update_views, via: [:get, :post, :put]

	get '*path' => 'odania/menu#show_page'

	root to: 'odania/menu#index'
end
