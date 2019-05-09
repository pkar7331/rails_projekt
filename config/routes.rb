Rails.application.routes.draw do
  


  resources :auctions do
  	resources :tickets, except: [:index], controller: 'auctions/tickets'
	end
  devise_for :users

  get '/users/:id' => 'users#show', :as => :user

  root 'auctions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
