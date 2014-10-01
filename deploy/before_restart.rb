run "cd /srv/www/inreviapp/current && RAILS_ENV=production /usr/local/bin/bundle exec rake assets:precompile"
run "bundle exec rake db:seed"
run "bundle exec rake promote_admin"