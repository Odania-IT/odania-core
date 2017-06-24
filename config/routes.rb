Rails.application.routes.draw do
	namespace :admin do
		resources :languages

		root to: 'home#index'
	end

	namespace :protected do
		root to: 'home#index'
	end

	scope '/:locale', constraints: {locale: /[a-z][a-z]/} do
		get 'categories' => 'categories#index'
		get 'categories/:id' => 'categories#show'

		root to: 'home#index', as: :locale_root
	end

	devise_for :users, controllers: {registrations: 'registration'}
	devise_for :admins

	root to: 'home#redirect_to_locale'
end
