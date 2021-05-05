Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'prefectures#index'
  resources :prefectures, only: [:index] do
    resources :councils, only: [:index] do
      resources :assemblymen, only: [:index, :show, :edit, :update] do
        resources :assemblyman_comments, only: [:new, :create, :destroy]
      end
    end
  end
  resources :searches, only: [:index]

  resources :manifests do
    collection do
      get 'search'
    end
    resources :manifest_comments, only: [:new, :create, :destroy]
  end
  resources :tags, only: [:index, :show]
end
