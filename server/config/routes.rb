Rails.application.routes.draw do
=begin
  devise_for :users
  devise_for :workers
=end

=begin
  devise_scope :worker do
    get '/login' => 'sessions#new', :as => :login
    get '/logout' => 'sessions#destroy', :as => :logout
  end
=end

  resources :patients, except: :destroy do
    # get '/delete', to: 'patients#delete'
    delete '/', to: 'patients#delete'
  end
  resources :analysis do
    get '/prediction', to: 'analysis#calculate'
  end
  resources :workers, only: [:show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/auth/login', to: 'authentication#login'
  get '/*', to: 'application#not_found'
end
