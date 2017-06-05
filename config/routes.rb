Rails.application.routes.draw do
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 # get '/signup' => "registrations#new", as: :new_user
 # post '/registrations/create', to: "registrations#create", as: :create_new_user

 get '/login' => "sessions#new", as: :new_session
 post '/login', to: "sessions#create", as: :create_new_session
 get '/logout' => 'sessions#destroy'
 delete '/signout' => "sessions#destroy", as: :destroy_session

 resources :users


 # get 'users/:id' => "users#show" as: :show_user
 # delete 'users/:id' => "users#destroy" as: :destroy_user
 # get 'users/:id/edit' => "users#edit" as: :user_edit
 # patch 'users/:id' => "users#update" as:

 root 'welcome#greeting'
end
