get 'failure', to: 'sessions#failure'

get  '/:provider/callback', to: 'sessions#create'
post '/:provider/callback', to: 'sessions#create'

delete '/logout', to: 'sessions#destroy'
