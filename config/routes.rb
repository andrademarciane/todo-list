Rails.application.routes.draw do
  resources :boards
  resources :steps

  root to: "boards#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
