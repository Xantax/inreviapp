run "cd /srv/www/inreviapp/current && /usr/local/bin/bundle exec rake assets:precompile RAILS_ENV=production"
run "bundle exec rake db:seed"
run "bundle exec rake promote_admin"