# config valid only for current version of Capistrano
lock '3.5.0'

set :repo_url,        'git@bitbucket.org:myridz/avinashi-ktm.git'
set :application,     'avinashi-ktm'
set :user,            'deploy'

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma