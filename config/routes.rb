Cle2030::Application.routes.draw do

# Static Pages:
  get 'about'                   => 'static/about#index',             :as => :about
  get 'about/corporate'         => 'static/about#corporate',         :as => :about_corporate
  get 'about/directors'         => 'static/about#directors',         :as => :about_directors
  get 'about/directors-past'    => 'static/about#directors-past',    :as => :about_directors_past
  get 'benefits'                => 'static/benefits#index',          :as => :benefits
  get 'clevelandplus'           => 'static/clevelandplus#index',     :as => :cleveland_plus
  get 'involved'                => 'static/involved#index',          :as => :involved
  get 'involved/educational'    => 'static/involved#educational',    :as => :involved_educational
  get 'involved/networking'     => 'static/involved#networking',     :as => :involved_networking
  get 'involved/philanthropic'  => 'static/involved#philanthropic',  :as => :involved_philanthropic
  get 'involved/social'         => 'static/involved#social',         :as => :involved_social
  get 'logos'                   => 'static/logos#index',             :as => :logos

# Match Routes
  get '/calendar/:year/:month' => 'calendar#index', as: :calendar, constraints: { :month => /d{1,2}/, :year => /d{4}/ }
  get '/calendar' => 'calendar#index', as: :calendar
  get 'login' => 'user_sessions#new', as: :login
  get 'membership_rewards/categories/:id' => 'categories#show', as: :membership_rewards_category
  get 'membership_rewards/regions/:id' => 'regions#show', as: :membership_rewards_region

# Resource Routes

  resources :events, only: [:show] do
    match :register_member, on: :member, via: [:put, :post]
  end

  resources :guests
  resources(:members, only: [:index, :show, :update]) { collection { get :search } }
  resources :membership_rewards, only: [:show, :index]

  resource  :orders do
    put  :checkout, on: :collection
    post :complete, on: :collection
    put  :complete_rsvp, on: :member
    get  :confirm
  end

  resources :password_resets

  resource  :user do
    member { get :renewal }
    resources :profiles, only: [:new, :create, :edit, :update]
  end
  resource :user_session, only: [:new, :create, :destroy]

# Namespace Routes
  namespace :admin do
    resources :categories, except: [:index, :show]
    resources :events
    resources :regions, except: [:index, :show]
    resources :participants do
      resources :locations, except: [:index, :show]
    end
    resources :users do
      resources :board_terms, except: [:index, :show]
      get :search, on: :collection
      resources :membership_renewals, only: [:new, :create]
    end
    root to: 'dashboard#index'
  end

# Application Root
  root to: 'home#index'
end
