Rails.application.routes.draw do
  devise_for :users
  root to: 'prefectures#index'
  resources :prefectures, only: [:index, :show] do
    resources :councils, only: :show do
      resources :assemblymen, only: [:show] do
        resources :comments, only: [:new, :create]
      end
    end
  end
end
