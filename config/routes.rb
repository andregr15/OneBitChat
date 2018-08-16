Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  root to: 'teams#index'

  resources :teams, only: [:create, :destroy]
  get '/:slug', to: 'teams#show'
  
  resources :channels, only: [:show, :create, :destroy]
  resources :talks, only: [:show]
  resources :team_users, only: [:create, :destroy, :show]
  
  devise_for :users, :controllers => { registrations: 'registrations'}

  resources :invitations, only: [:create, :show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
