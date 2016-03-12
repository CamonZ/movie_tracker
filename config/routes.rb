Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
    namespace :v1 do
      resources :movies
    end
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
