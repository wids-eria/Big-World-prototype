export MONGOID_HOST=localhost
export MONGOID_DATABASE=bigworld_proto_devel
export MONGOID_PORT=$1

export RAILS_ENV=production
stalk lib/jobs/turtle_tick.rb > /dev/null &