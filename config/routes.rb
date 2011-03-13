ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'home'
  map.resources :events
  map.resources :guests
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :requirements => {:year => /d{4}/, :month => /d{1,2}/}, :year => nil, :month => nil
  map.resource :user_session
  map.resource :user
  map.account_edit 'accounts/edit/:id', :controller => 'accounts', :action => 'edit'
  map.resource :alert
  map.resource :registration
  map.resource :orders
	map.resources :members, :member => {:edit_login => :get}
  map.resources :reports
	map.resources :password_resets
    
  map.cleveland_plus 'clevelandplus', :controller => 'clevelandplus', :action => 'index'
  
  map.about 'about', :controller => 'about', :action => 'index'
  map.about_directors 'about/directors', :controller => 'about', :action => 'directors'
  map.about_corporate 'about/corporate', :controller => 'about', :action => 'corporate'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
