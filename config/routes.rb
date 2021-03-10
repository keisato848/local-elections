Rails.application.routes.draw do
  get 'search/index'
  devise_for :users
  root to: 'prefectures#index'
  resources :prefectures, only: [:index, :show] do
    resources :councils, only: [:show, :search] do
      member do
        get 'search'
        post 'search_result' 
      end
      resources :assemblymen, only: [:show] do
        resources :comments, only: [:new, :create]
      end
    end
  end
end
