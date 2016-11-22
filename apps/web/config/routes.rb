root to: 'tasks#index'

get '/tasks/:id', to: 'tasks#show', as: :task
get '/tasks/new', to: 'tasks#new'

post '/tasks',    to: 'tasks#create'
