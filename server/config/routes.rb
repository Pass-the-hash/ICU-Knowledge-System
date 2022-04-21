Rails.application.routes.draw do
  devise_for :users
  devise_for :workers

=begin
  devise_scope :worker do
    get '/login' => 'sessions#new', :as => :login
    get '/logout' => 'sessions#destroy', :as => :logout
  end
=end
  resources :workers
  resources :patients, except: :destroy do
    # get '/delete', to: 'patients#delete'
    delete '/', to: 'patients#delete'
  end
  resources :analysis do
    get 'calculate', to: 'analysis#calculate'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
