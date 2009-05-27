#############################################################
#	Application
#############################################################

set :application, "movielist"
set :deploy_to, "/home/dentarg/www/movielist"
set :shared_path, "#{deploy_to}/shared"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production" 

#############################################################
#	Servers
#############################################################

set :user, "dentarg"
set :domain, "beaver.starkast.net"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "production"
set :repository, "git@github.com:dentarg/movielist.git"
set :port, 2020
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :git_enable_submodules, 1
set :keep_releases, 5

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Link in uploaded stuff"
  task :relink_shared_directories, :roles => :app do
    run "ln -fs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
    
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end

after "deploy:update", "deploy:relink_shared_directories"
after "deploy:update", "deploy:cleanup"