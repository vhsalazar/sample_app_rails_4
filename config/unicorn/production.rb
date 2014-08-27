# # paths
# app_path = "/var/www"
# working_directory "#{app_path}/my_app"
# pid               "#{app_path}/my_app/shared/tmp/pids/unicorn.pid"

# # listen
# listen "/var/www/my_app/shared/my_app.socket", :backlog => 64

# # logging
# stderr_path "log/unicorn.stderr.log"
# stdout_path "log/unicorn.stdout.log"

# # workers
# worker_processes 3

# # use correct Gemfile on restarts
# before_exec do |server|
#   ENV['BUNDLE_GEMFILE'] = "#{app_path}/my_app/Gemfile"
# end

# # preload
# preload_app true

# before_fork do |server, worker|
#   # the following is highly recomended for Rails + "preload_app true"
#   # as there's no need for the master process to hold a connection
#   if defined?(ActiveRecord::Base)
#     ActiveRecord::Base.connection.disconnect!
#   end

#   # Before forking, kill the master process that belongs to the .oldbin PID.
#   # This enables 0 downtime deploys.
#   old_pid = "#{server.config[:pid]}.oldbin"
#   if File.exists?(old_pid) && server.pid != old_pid
#     begin
#       Process.kill("QUIT", File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#       # someone else did our job for us
#     end
#   end
# end

# after_fork do |server, worker|
#   if defined?(ActiveRecord::Base)
#     ActiveRecord::Base.establish_connection
#   end
# end



root = "/var/www/my_app/current"
working_directory(root)
# pid "#{root}/tmp/pids/unicorn.pid"
pid "/var/www/my_app/shared/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
 
# Port configuration
listen 3000
worker_processes 2
timeout 30
 
# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end