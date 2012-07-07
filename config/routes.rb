Cle2030::Application.routes.draw do

# Static Pages:
  get 'about' => 'about#index', :as => :about
  get 'about/corporate' => 'about#corporate', :as => :about_corporate
  get 'about/directors' => 'about#directors', :as => :about_directors
  get 'clevelandplus' => 'clevelandplus#index', :as => :cleveland_plus
  get 'logos' => 'logos#index', :as => :logos

# Match Routes
  get 'accounts/edit/:id' => 'accounts#edit', :as => :account_edit
  get '/calendar/:year/:month' => 'calendar#index', :as => :calendar, :constraints => { :month => /d{1,2}/, :year => /d{4}/ }
  get '/calendar' => 'calendar#index', :as => :calendar
  get 'login' => 'user_sessions#new', :as => :login
  get 'membership_rewards/categories/:id' => 'categories#show', :as => :membership_rewards_category
  get 'membership_rewards/regions/:id' => 'regions#show', :as => :membership_rewards_region

# Resource Routes
  resource  :alert
  resources :events
  resources :guests
  resources(:members, :only => [:index, :show]) { collection { get :search } }
  resources :membership_rewards, :only => [:show, :index]
  resource  :orders
  resources :password_resets
  resource  :registration
  resources :reports
  resource  :user do
    member { get :renewal }
    resources :profiles, :only => [:new, :create, :edit, :update]
  end
  resource :user_session
  
# Namespace Routes
  namespace :admin do
    resources :categories, :except => [:index, :show]
    resources :regions, :except => [:index, :show]
    resources :participants do
      resources :locations, :except => [:index, :show]
    end
    root :to => 'dashboard#index'
  end

# Application Root
  root :to => 'home#index'
end
