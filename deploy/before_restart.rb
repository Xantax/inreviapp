run "cd /srv/www/inreviapp/current && /usr/local/bin/RAILS_ENV='production' bundle exec rake assets:precompile"
run "bundle exec rake db:seed"
run "bundle exec rake promote_admin"