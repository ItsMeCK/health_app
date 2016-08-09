# config valid only for current version of Capistrano
lock '3.5.0'

set :repo_url,        'git@bitbucket.org:myridz/coromandel-harley-davidson.git'
set :application,     'chd'
set :user,            'deploy'

# Whenevr setup
after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma