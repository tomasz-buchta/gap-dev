Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root controller: :pages, action: :root
  namespace :api do
    namespace :v1 do
      namespace :private do
        resources :locations, param: :country_code, only: [:show]
        resources :target_groups, param: :country_code, only: [:show]
        resources :target_evaluation, only: [:create]
      end
      namespace :public do
        resources :locations, param: :country_code, only: [:show]
        resources :target_groups, param: :country_code, only: [:show]
      end
    end
  end
end
