Sidekiq tasks for Capistrano 3

If using the Sidekiq gem with Capistrano version 3, you may like a simple set of start, stop and restart tasks. There are a few gems out there already built to help you with this, which might be suitable for your project. If you however just want a simple script then you may use this sidekiq namespace I wrote and tweak it to your needs.

Place the following in your deploy.rb

namespace :sidekiq do
  def sidekiq_pid
    current_path + '../shared/pids/sidekiq.pid'
  end

  def pid_file_exists?
    test(*("[ -f #{sidekiq_pid} ]").split(' '))
  end

  def pid_process_exists?
    pid_file_exists? and test(*("kill -0 $( cat #{sidekiq_pid} )").split(' '))
  end

  task :start do
    on roles(:app) do
      if !pid_process_exists?
        execute "cd #{current_path} && RAILS_ENV=#{fetch(:rails_env)} #{fetch(:rbenv_prefix)} bundle exec sidekiq -C config/sidekiq.yml -e #{fetch(:rails_env)} -L log/sidekiq.log -P #{sidekiq_pid} -d"
      end
    end
  end

  task :stop do
    on roles(:app) do
      if pid_process_exists?
        execute "kill `cat #{sidekiq_pid}`"
        execute "rm #{sidekiq_pid}"
      end
    end
  end

  task :restart do
    on roles(:app) do
      invoke "sidekiq:stop"
      invoke "sidekiq:start"
    end
  end
end

after 'deploy:restart', 'sidekiq:start'
Notes
This script assumes you make use of the Sidekiq pid file.
The script assumes you are running a single instance of the Sidekiq daemon
You may need to edit some of the path names and/or commands for your particular setup
I run the sidekiq:restart task after deploy:restart, you may need a different task as the after hook.
If you're looking for something a little stronger, try the capistrano-sidekiq gem
