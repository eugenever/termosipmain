require 'rvm/capistrano' # Для работы rvm
require 'bundler/capistrano' # Для работы bundler. При изменении гемов bundler автоматически обновит все гемы на сервере, чтобы они в точности соответствовали гемам разработчика. 

set :rvm_ruby_string, '2.0.0@termosipmain' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :application, "termosipmain"
set :rails_env, "production"
set :domain, "depuser@termosip.ru" # Это необходимо для деплоя через ssh. Именно ради этого я настоятельно советовал сразу же залить на сервер свой ключ, чтобы не вводить паролей.
set :deploy_to, "/srv/#{application}"
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use #{rvm_ruby_string} do bundle exec unicorn_rails -Dc #{unicorn_conf})"
set :keep_releases, 3 #число релизов оставляемых после деплоя
set :shared_children, shared_children + %w{public/ckeditor_assets} #чтобы не удалялись предыдущие ассеты из ckeditor
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  "git@github.com:eugenever/termosipmain.git" # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить их в deployment keys в настройках репозитария.
set :branch, "master" # Ветка из которой будем тянуть код для деплоя.
set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

role :web, domain
role :app, domain
role :db,  domain, :primary => true

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.

after 'deploy:update_code', :roles => :app do
  #run "rm -f #{current_release}/config/database.yml"
  #run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
  run " cd #{release_path} && RAILS_ENV=production bundle exec rake sitemap:generate"
  run " cd #{release_path} &&  RAILS_ENV=production bundle exec rake sitemap:symlink"
end

namespace :symlinks do
  desc "generate and copy the symlink"
  task :generate_sitemap do
    run " cd #{release_path} && RAILS_ENV=production bundle exec rake sitemap:generate"
    run " cd #{release_path} &&  RAILS_ENV=production bundle exec rake sitemap:symlink"
  end
end

after "deploy", "deploy:cleanup"

desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets, roles: :app do
  run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:create_nondigest_assets"
end
after 'deploy:assets:precompile', 'copy_nondigest_assets'

# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
# В случае с Rails 3 приложениями стоит заменять bundle exec unicorn_rails на bundle exec unicorn
namespace :deploy do
  task :restart do
    #run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
     run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end