get  'failure',             to: 'sessions#failure'
get  '/:provider/callback', to: 'sessions#create'
post '/:provider/callback', to: 'sessions#create'
get  '/logout',             to: 'sessions#destroy'
