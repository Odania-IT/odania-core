Rails.application.routes.draw do
	mount Ckeditor::Engine => '/ckeditor'
	resources :contents, module: 'odania', as: 'odania_contents', only: [:index, :show]

	match '/deliver/click' => 'odania/deliver#click', via: [:get, :post], as: :deliver_click

	get '/imprint' => 'info#imprint'
	get '/contact' => 'info#contact'
	post '/contact' => 'info#contact_send'

	namespace :admin do
		namespace :odania do
			resources :contents
			resources :menus
			resources :sites
			resources :languages
		end
		get '/' => 'dashboard#index'
	end

	# Track views
	match "track_view/:type/:id" => "odania/statistics#track_view", :as => :update_views, via: [:get, :post, :put]

	root to: 'odania/welcome#index'
end
