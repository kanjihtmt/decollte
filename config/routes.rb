Rails.application.routes.draw do
  #get '/admin', to: 'admin/brands#index'
  root 'brands#index'

  namespace :admin do
    root 'brands#index'
    devise_for :administrators, skip: :all
    devise_scope :admin_administrator do
      get 'login'         => 'sessions#new'
      post 'login'        => 'sessions#create'
      get 'logout'        => 'sessions#destroy'
      get 'password/new'  => 'passwords#new'
      post 'password'     => 'passwords#create'
      get 'password/edit' => 'passwords#edit'
      put 'password'      => 'passwords#update'
      resources :registrations
    end
  end


  resources :brands
  scope '/:brand' do
    resources :shops
  end

  get 'shops/:brand', to: 'shops#index'
end
