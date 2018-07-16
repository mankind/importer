Rails.application.routes.draw do
  resources :attachments  do
    post :import, on: :collection
  end
  resources :books
  devise_for :users

  root to: "books#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
