Rails.application.routes.draw do
  resources :tasks
  resources :boards

  root to: "boards#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
