Rails.application.routes.draw do
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 get '/signup' => "registrations#new", as: :new_user
 post '/users/create', to: "registrations#create", as: :create_new_user

 get '/signin' => "sessions#new", as: :new_session
 post '/sessions/create', to: "sessions#create", as: :create_new_session
 delete '/signout' => "sessions#destroy", as: :destroy_session

 resources :users, only: [:show, :destroy, :edit, :update]


 # get 'users/:id' => "users#show" as: :show_user
 # delete 'users/:id' => "users#destroy" as: :destroy_user
 # get 'users/:id/edit' => "users#edit" as: :user_edit
 # patch 'users/:id' => "users#update" as:

 root 'welcome#greeting'
end
