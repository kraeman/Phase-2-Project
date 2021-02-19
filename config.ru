$LOAD_PATH.unshift '.'
#$LOAD_PATH is similar to require...used to locate gems and find the dependent classes.
require 'config/environment'

# use Rack::Static, urls: ['/css'], root: 'public'

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use CakesController
use UsersController
use SessionsController
run ApplicationController

