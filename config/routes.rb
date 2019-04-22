Rails.application.routes.draw do
  namespace :admin do
    namespace :sortable do
      get 'shops/update'
    end
  end
  root 'brands#index'

  namespace :admin do
    root 'brands#index'
    devise_for :administrators, skip: :all
    devise_scope :admin_administrator do
      get 'login'  => 'sessions#new'
      post 'login' => 'sessions#create'
      get 'logout' => 'sessions#destroy'
    end
    namespace :sortable do
      resources :brand, only: [] do
        resources :shops, only: %i(update)
      end
    end
    resources :brands, except: %i(show destroy) do
      resources :shops, except: %i(show)
    end
    resources :administrators, except: %i(show)
  end

  resources :brands, only: %i(index)
  get 'shops/:brand', to: 'shops#index'
end
