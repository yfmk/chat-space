# config valid only for current version of Capistrano
lock '~> 3.11.0'

set :application, 'chat-space'
set :repo_url,  'git@github.com:yfmk/chat-space.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWZtpL5ol5Fhx4iGMMmE7JsPZ1Ul8rft/Bxg9+2+sKugOM+eaS9pkKALPdglXlEiSDre7gByeOemX2S4jgU1r8hwlHywVYIpFAA9h+dgMlIi14whBMm1kw9F2agJyzNGLjn59Wj2HE8N9qIGKYub7To8wdbl30djUR9q7xh17gXiWwCNjHFM5Y69+RMgcaOPpb+mx2fMMVNKv6JEgLPeAclgqP7LrDZ/ob+7aK28Qf2dRgD8YOMJ/PVQ9XVnBN2nj/LW4i+Tua5mUaVilrsRGG2XnLQzraLtAmla7HjPqJkQM2gT3SC2mLgkKo3m0Br7JPC/eTUerbCpu1kQvqiaUtMtsi3iOUiQ9zuk7n2mRW28ItvAlfm+K1fBqOkdGBeRl9y0uqctFfuJLiHiElDFy+WagxgJnwlVcqvL++RXNKBWjkahJaGyyts9VJTcjKh0oHXjhQ27zk5PiuMYI/AW6FtBMfk9xb5krJxQCOh5ob7M5QHUx7yRxYCmzDef3wz6sb9X0z9ta3GLUKyny9/Slzip+LWKqjVxtnLJmEzEuFtB9GdQdSE0D5IP3N88s7BTwmmh2OKrgnaQIaQI8BCZ3HKiKXiubAxicRUk9PzUNRDcoVgiI3e40600Aialy1PxHCOQdn1QauXmi7zoM5O9OOsb7vxog7KFHAHpdOjWC5fw==']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end