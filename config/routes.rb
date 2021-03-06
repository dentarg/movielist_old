ActionController::Routing::Routes.draw do |map|
  map.resources :movie_nights, :member => { :search => :post }

  map.resources :movies,
    :member => { :seen => :post, :towatch => :post, :favorite => :post }

  map.resources :seen
  map.resources :towatch
  map.resources :favorites
 
  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }
  
  # Restful Authentication Resources
  map.resources :users, :has_many => [:seen, :towatch, :favorites] do |user|
    user.resources :movie_nights,
      :member => { :register => :post, :unregister => :post }
    end
  map.resources :passwords
  map.resource :session
  
  # Home Page
  map.root :controller => 'public', :action => 'index'
  #map.root :controller => 'sessions', :action => 'new'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
