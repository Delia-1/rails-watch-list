Rails.application.routes.draw do
  root to: "lists#index"
  resources :lists, only: [:show, :new, :create] do
    resources :bookmarks, only: [:create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
# Rails.application.routes.draw do
#   resources :lists, only: [:index, :show, :new, :create] do
#     resources :bookmarks, only: [:create]
#   end

#   resources :movies, only: [:index, :show, :new, :create] do
#     collection do
#       get :latest_movies  # Updated for clarity
#     end
#   end

#   # Health check route
#   get "up" => "rails/health#show", as: :rails_health_check
# end
