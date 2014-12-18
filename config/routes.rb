Rails.application.routes.draw do

  root 'pages#index'
  get '/about' => 'pages#about'
  post '/sign_up' => 'users#create' # Could not get users_path POSTing
  get '/show_my_auctions' => 'auctions#show_my'

	get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/change_password' => 'users#pass'
  post '/change_password' => 'users#password'

  get '/bids' => 'bids#new'
  post '/bids' => 'bids#create'

  get '/bid_history' => 'bid_historys#show'

  get '/watcher' => 'watchers#new'
  delete '/watcher' => 'watchers#destroy'

  resources :pages
  resources :session
  resources :auctions
  resources :users
  resources :questions_answers

end
