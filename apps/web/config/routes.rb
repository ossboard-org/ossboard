root to: 'main#index'

get '/about',       to: 'static#about', as: 'about'
get '/how-to-help', to: 'static#help',  as: 'help'

resources :tasks, only: %i[index new create show]
