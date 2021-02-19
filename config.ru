$LOAD_PATH.unshift '.'
#$LOAD_PATH is similar to require...used to locate gems and find the dependent classes.
require 'config/environment'

# use Rack::Static, urls: ['/css'], root: 'public'
#The Rack::Static middleware intercepts requests for static files (javascript files,
#images, stylesheets, etc) based on the url prefixes or route mappings passed in the options,
#and serves them using a Rack::Files object. This allows a Rack stack to serve both static and 
#dynamic content.


if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use CakesController
use UsersController
use SessionsController
run ApplicationController

