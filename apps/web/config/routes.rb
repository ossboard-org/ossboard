root to: 'tasks#index'

resources :tasks, only: [:new, :create, :show]
