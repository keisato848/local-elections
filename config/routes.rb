Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'prefectures#index'
  resources :prefectures, only: [:index] do
    resources :councils, only: [:index, :show, :search] do
      member do
        get 'search'
        post 'search_result' 
      end
      resources :assemblymen, only: [:index, :show, :edit, :update] do
        resources :comments, only: [:new, :create]
      end
    end
  end

  resources :manifests do
    collection do
      get 'search'
    end
  end
  resources :tags, only: [:index, :show]
end
