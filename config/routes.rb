Rails.application.routes.draw do

  resources :comments, :categories, :users

  resources :habits do
    resources :comments
    resources :goals do
      resources :milestones do
        resources :statuses
      end
    end
  end

 get '/auth/facebook/callback' => 'sessions#create'
 get '/login' => "sessions#new", as: :new_session
 post '/login', to: "sessions#create", as: :create_new_session
 get '/logout' => 'sessions#destroy'
 delete '/signout' => "sessions#destroy", as: :destroy_session


 put '/users/:id/change_role', to: 'users#change_role', as: 'change_role'
 get '/users/:id/habits', to: 'users#personal_habits', as: 'personal_habits'

 patch '/habits/:id/addgoals', to: 'habits#update_goals', as: 'update_goals'
 patch '/habits/:habit_id/goals/:id/addmilestones', to: 'goals#update_milestones', as: 'update_milestones'
 patch '/habits/:habit_id/goals/:goal_id/:milestones/:id/addstatusestoms', to: 'milestones#update_statuses', as: 'update_statuses'

 root 'welcome#greeting'
end
