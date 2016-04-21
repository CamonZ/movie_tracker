Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, only: :registrations, controllers: {
    registrations: 'users/registrations'
  }, defaults: { format: :json }

  namespace :api do
    namespace :v1 do

      resources :movies, except: :create do
        post 'import', on: :collection
      end

      resources :collections do
        resources :movies, only: [:add, :remove] do
          post 'add', to: 'movies#add_to_collection', on: :collection
          delete 'remove', to: 'movies#remove_from_collection', on: :collection
        end
      end
    end
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
