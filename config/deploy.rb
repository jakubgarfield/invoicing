# config valid only for current version of Capistrano
lock "3.8.0"

set :application, 'invoicing'
set :repo_url, 'git@github.com:jakubgarfield/invoicing.git'
set :deploy_to, '/home/deploy/invoicing'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# set :bundle_binstubs, nil
append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
