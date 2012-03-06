export MONGOID_HOST=localhost
export MONGOID_DATABASE=bigworld_proto_devel
export MONGOID_PORT=$1
export BEANSTALK_URL="beanstalk://localhost:11300/,beanstalk://localhost:11302/,beanstalk://localhost:11302/"


export RAILS_ENV=production
stalk lib/jobs/turtle_tick.rb > /dev/null &