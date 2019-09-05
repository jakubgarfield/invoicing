role :app, %w{deploy@13.84.220.173}
role :web, %w{deploy@13.84.220.173}
role :db,  %w{deploy@13.84.220.173}

server '13.84.220.173', user: 'deploy', roles: %w{web app db}
