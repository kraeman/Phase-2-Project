$LOAD_PATH.unshift '.'
require 'config/environment'

use Rack::Static, urls: ['/css'], root: 'public'

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use CakeController
# use IngredientController
# use GiftController
# use UserController
run ApplicationController
