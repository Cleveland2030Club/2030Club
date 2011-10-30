ActionController::Routing::Routes.draw do |map|
  #Matched Routes
  map.about 'about', :controller => 'about', :action => 'index'
  map.about_corporate 'about/corporate', :controller => 'about', :action => 'corporate'
  map.about_directors 'about/directors', :controller => 'about', :action => 'directors'
  map.account_edit 'accounts/edit/:id', :controller => 'accounts', :action => 'edit'
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :requirements => {:year => /d{4}/, :month => /d{1,2}/}, :year => nil, :month => nil
  map.cleveland_plus 'clevelandplus', :controller => 'clevelandplus', :action => 'index'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logos 'logos', :controller => 'logos', :action => 'index'

  #Resource Declared Routes
  map.resource    :alert
  map.resources   :events
  map.resources   :guests
  map.resources   :members, :member => {:edit_login => :get}
  map.resource    :orders
  map.resources   :password_resets
  map.resources   :membership_rewards, :only => [:show, :index]
  map.resource    :registration
  map.resources   :reports
  map.resource    :user
  map.resource    :user_session

  #Namespaced Routes
  map.namespace(:admin) do |admin|
    admin.root :controller => 'dashboard', :action => 'index'
    admin.resources :categories, :except => [:index, :show]
    admin.resources :regions, :except => [:index, :show]
    admin.resources :participants do |participant|
      participant.resources :locations, :except => [:index, :show]
    end
  end
 
  #Home
  map.root :controller => 'home'

  #Nonrestful Routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end