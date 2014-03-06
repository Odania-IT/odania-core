Rails.application.routes.draw do
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
	end

	root to: 'odania/welcome#index'
end
