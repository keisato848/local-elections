Rails.application.routes.draw do
  devise_for :users
  root to: 'prefectures#index'
  resources :prefectures, only: [:index, :show] do
    resources :councils do
      resources :assemblymen, only: [:index]
    end
  end
end
