task :promote_admin => :environment do
  User.first.update(admin: true)
end