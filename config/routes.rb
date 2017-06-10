Rails.application.routes.draw do

  resources :comments, :categories, :users

  resources :habits do
    resources :goals do
      resources :milestones do
        resources :statuses
      end
    end
  end

  # resources :habits do
  #   resources :goals
  # end

  # resources :goals do
  #   resources :milestones
  # end

 # get '/signup' => "registrations#new", as: :new_user
 # post '/registrations/create', to: "registrations#create", as: :create_new_user
 get '/auth/facebook/callback' => 'sessions#create'
 get '/login' => "sessions#new", as: :new_session
 post '/login', to: "sessions#create", as: :create_new_session
 get '/logout' => 'sessions#destroy'
 delete '/signout' => "sessions#destroy", as: :destroy_session


 put '/users/:id/change_role', to: 'users#change_role', as: 'change_role'
 get '/users/:id/habits', to: 'users#personal_habits', as: 'personal_habits'
 patch '/habits/:habit_id/goals/:id/addmilestones', to: 'goals#update_milestones', as: 'update_milestones'
 patch '/habits/:habit_id/goals/:goal_id/:milestones/:id/addstatusestoms', to: 'goals#update_statuses', as: 'update_statuses'



 # get 'auth/google_oauth2/callback' => 'sessions#create'
 # get 'auth/:provider/callback', to: 'sessions#create'
 # get 'auth/failure', to: redirect('/')

 root 'welcome#greeting'
end
