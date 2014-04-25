Rails.application.routes.draw do
	mount Ckeditor::Engine => '/ckeditor'

	match '/deliver/click' => 'odania/deliver#click', via: [:get, :post], as: :deliver_click

	get '/imprint' => 'info#imprint'
	get '/contact' => 'info#contact'
	post '/contact' => 'info#contact_send'

	namespace :admin do
		namespace :odania do
			resources :menus do
				resources :menu_items, controller: 'menu_items', as: 'odania_menu_items' do
					member do
						get :set_default
					end
				end
				resources :contents, controller: 'contents', as: 'odania_contents'

				collection do
					post :select_odania_menu
				end
			end
			get 'menu_items' => 'menu_items#overview'
			get 'contents' => 'contents#overview'
			resources :sites
			resources :languages
		end
		get '/' => 'dashboard#index'
	end

	# Track views
	match 'track_view/:type/:id' => 'odania/statistics#track_view', :as => :update_views, via: [:get, :post, :put]

	scope '/:locale', constraints: {locale: /[a-z][a-z]/} do
		resources :contents, only: [:index, :show], controller: 'odania/contents', as: 'odania_content'
		get 'tags' => 'odania/tags#index'
		get 'tags/:tag' => 'odania/tags#show', as: :tag

		get '/*path' => 'odania/menu#show_page'
		root to: 'odania/menu#menu_index', as: :locale_root
	end

	root to: 'odania/menu#index'
end
