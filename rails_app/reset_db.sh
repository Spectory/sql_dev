rake db:drop
rake db:create
rake db:migrate
RAILS_ENV=test rake db:migrate
rake db:seed
