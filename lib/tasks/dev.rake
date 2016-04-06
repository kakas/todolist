namespace :dev do
  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  desc "Rebuild system and add seed"
  task :rebuild => ["dev:build", "db:seed"]
end
