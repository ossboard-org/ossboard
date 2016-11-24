resources :tasks, only: %i[index show edit update]

root to: 'dashboard#index'
