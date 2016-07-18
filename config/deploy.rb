# config valid only for current version of Capistrano
lock '3.5.0'

set :repo_url,        'git@bitbucket.org:myridz/coromandel-harley-davidson.git'
set :application,     'chd'
set :user,            'deploy'
set :bundle_binstubs, nil

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma