Rails.application.routes.draw do
	devise_for :users, class_name: 'Odania::User', :controllers => {registrations: 'odania/registration'}
	match '/deliver/click' => 'odania/deliver#click', via: [:get, :post], as: :deliver_click

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
			resources :widgets
		end

		namespace :api, defaults: {format: :json} do
			get 'bootstrap' => 'bootstrap#index'
			post 'bootstrap/change_language' => 'bootstrap#change_language'

			resources :sites, except: [:new, :edit] do
				resources :menus, except: [:new, :edit] do
					resources :categories, except: [:new, :edit]
					resources :contents, except: [:new, :edit]
					resources :medias, except: [:new, :edit]
					resources :static_pages, except: [:new, :edit]
					resources :menu_items, except: [:new, :edit] do
						collection do
							get :initial_data
						end

						member do
							post :set_default
						end
					end
				end
				resources :widgets, except: [:new, :edit]
			end

			resources :languages, except: [:new, :edit]
		end
		get '/templates/*template' => 'template#index', as: :admin_template

		get '/' => 'dashboard#index'
	end

	namespace :protected do
		namespace :api, defaults: {format: :json} do
			resources :medias, except: [:new, :edit]
			get 'bootstrap' => 'bootstrap#index'
			post 'bootstrap/change_language' => 'bootstrap#change_language'
		end
		get '/templates/*template' => 'template#index', as: :protected_template

		get '/' => 'dashboard#index'
	end

	namespace :odania do
		namespace :api, defaults: {format: :json} do
			resources :categories
			resources :contents
			resources :sites
			resources :static_pages
			get 'users/me' => 'users#me'
			get 'bootstrap' => 'bootstrap#index'
			post 'authenticate/token' => 'authenticate#token'
			get 'authenticate/verify' => 'authenticate#verify'
			post 'authenticate/development' => 'authenticate#development'
			post 'authenticate/facebook' => 'authenticate#facebook'
		end

		get '/templates/*template' => 'template#index', as: :odania_template
	end

	# Track views
	match 'track_view/:type/:id' => 'odania/statistics#track_view', :as => :update_views, via: [:get, :post, :put]

	scope '/:locale', constraints: {locale: /[a-z][a-z]/} do
		resources :contents, only: [:index, :show], controller: 'odania/contents', as: 'odania_content'
		get 'tags' => 'odania/tags#index'
		get 'tags/auto_complete' => 'odania/tags#auto_complete'
		get 'tags/:tag' => 'odania/tags#show', as: :tag

		get 'categories' => 'odania/categories#index'
		get 'categories/:id' => 'odania/categories#show', as: :category

		get 'static_pages/:id' => 'odania/static_pages#show', as: :static_page

		get 'imprint' => 'odania/info#imprint'
		get 'terms_and_conditions' => 'odania/info#terms_and_conditions'
		get 'contact' => 'odania/info#contact'
		post 'contact' => 'odania/info#contact_send'

		get 'search' => 'odania/search#index'
		post 'search' => 'odania/search#search'

		get '/*path' => 'odania/menu#show_page'
		root to: 'odania/menu#menu_index', as: :locale_root
	end

	root to: 'odania/menu#index'
end
