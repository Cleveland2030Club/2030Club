Cle2030::Application.routes.draw do
  get 'about' => 'about#index', :as => :about
  get 'about/corporate' => 'about#corporate', :as => :about_corporate
  get 'about/directors' => 'about#directors', :as => :about_directors
  get 'accounts/edit/:id' => 'accounts#edit', :as => :account_edit
  get 'benefits'  => 'benefits#index',  :as => :benefits
  get '/calendar/:year/:month' => 'calendar#index', :as => :calendar, :constraints => { :month => /d{1,2}/, :year => /d{4}/ }
  get '/calendar' => 'calendar#index', :as => :calendar
  get 'clevelandplus' => 'clevelandplus#index', :as => :cleveland_plus
  get 'involved'                => 'involved#index',          :as => :involved
  get 'involved/educational'    => 'involved#educational',    :as => :involved_educational
  get 'involved/networking'     => 'involved#networking',     :as => :involved_networking
  get 'involved/philanthropic'  => 'involved#philanthropic',  :as => :involved_philanthropic
  get 'involved/social'         => 'involved#social',         :as => :involved_social
  get 'login' => 'user_sessions#new', :as => :login
  get 'logos' => 'logos#index', :as => :logos
  get 'membership_rewards/categories/:id' => 'categories#show', :as => :membership_rewards_category
  get 'membership_rewards/regions/:id' => 'regions#show', :as => :membership_rewards_region

  resource :alert
  resources :events
  resources :guests
  resources :members, :only => [:index, :show] do
    collection do
      get :search
    end
  end

  resource :orders
  resources :password_resets
  resources :membership_rewards, :only => [:show, :index]
  resource :registration
  resources :reports
  resource :user do
    member do
      get :renewal
    end
    resources :profiles, :only => [:new, :create, :edit, :update]
  end
  resource :user_session

  namespace :admin do
    match '/' => 'dashboard#index'
    resources :categories, :except => [:index, :show]
    resources :regions, :except => [:index, :show]
    resources :participants do
      resources :locations, :except => [:index, :show]
    end
  end

  root :to => 'home#index'
  match '/:controller(/:action(/:id))'
end
