Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'prefectures#index'
  resources :prefectures, only: [:index] do
    resources :councils, only: [:index, :show, :search] do
      resources :assemblymen, only: [:index, :show, :edit, :update] do
        collection do
          get 'search'
          post 'search_result' 
        end
        resources :assemblyman_comments, only: [:new, :create, :destroy]
      end
    end
  end

  resources :manifests do
    collection do
      get 'search'
    end
    resources :manifest_comments, only: [:new, :create, :destroy]
  end
  resources :tags, only: [:index, :show]
end
