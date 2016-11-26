root to: 'main#index'

resources :tasks, only: %i[index new create show]
