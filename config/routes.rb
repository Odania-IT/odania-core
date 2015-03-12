Rails.application.routes.draw do
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
		get '/templates/*template' => 'template#index'

		get '/' => 'dashboard#index'
	end

	namespace :protected do
		get '/' => 'dashboard#index'
	end

	# Track views
	match 'track_view/:type/:id' => 'odania/statistics#track_view', :as => :update_views, via: [:get, :post, :put]

	scope '/:locale', constraints: {locale: /[a-z][a-z]/} do
		resources :contents, only: [:index, :show], controller: 'odania/contents', as: 'odania_content'
		get 'tags' => 'odania/tags#index'
		get 'tags/auto_complete' => 'odania/tags#auto_complete'
		get 'tags/:tag' => 'odania/tags#show', as: :tag

		get 'imprint' => 'odania/info#imprint'
		get 'terms_and_conditions' => 'odania/info#terms_and_conditions'
		get 'contact' => 'odania/info#contact'
		post 'contact' => 'odania/info#contact_send'

		get '/*path' => 'odania/menu#show_page'
		root to: 'odania/menu#menu_index', as: :locale_root
	end

	root to: 'odania/menu#index'
end
