root to: 'tasks#index'

get '/tasks/new', to: 'tasks#new',  as: :new_task
get '/tasks/:id', to: 'tasks#show', as: :task

post '/tasks',    to: 'tasks#create', as: :task
