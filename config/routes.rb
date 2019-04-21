Rails.application.routes.draw do
  root 'brands#index'

  namespace :admin do
    root 'brands#index'
    devise_for :administrators, skip: :all
    devise_scope :admin_administrator do
      get 'login'  => 'sessions#new'
      post 'login' => 'sessions#create'
      get 'logout' => 'sessions#destroy'
    end
    resources :brands, except: %i(show destroy)
    resources :shops, except: %i(show)
  end

  resources :brands, only: %i(index)
  scope '/:brand' do
    resources :shops
  end
  get 'shops/:brand', to: 'shops#index'
end
