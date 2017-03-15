Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root :to => 'reservations#new'

  resources :reservations do
    member do
      get "change_status"
    end
    collection do
      get "calendar1"
      get "calendar30"
      get "hotel_list"
    end
  end
end
