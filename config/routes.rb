Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'prefectures#index'
  resources :prefectures, only: [:index, :show] do
    resources :councils, only: [:show, :search] do
      member do
        get 'search'
        post 'search_result' 
      end
      resources :assemblymen, only: [:show, :edit, :update] do
        resources :comments, only: [:new, :create]
      end
    end
  end

  resources :manifests, only:[:new, :create]
end
