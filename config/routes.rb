Rails.application.routes.draw do
  resources :votes
  resources :elections do
    collection do
      get 'categories'
    end
  end
  resources :groups
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
