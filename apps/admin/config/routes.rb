resources :tasks, only: %i[index show update]

root to: 'dashboard#index'
