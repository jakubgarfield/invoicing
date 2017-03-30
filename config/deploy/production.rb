role :app, %w{deploy@107.170.69.55}
role :web, %w{deploy@107.170.69.55}
role :db,  %w{deploy@107.170.69.55}

server '107.170.69.55', user: 'deploy', roles: %w{web app db}
