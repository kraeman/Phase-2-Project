require 'bundler/setup'
Bundler.require
require 'dotenv/load'
ENV['SINATRA_ENV'] ||= "development"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/bday#{ENV['SINATRA_ENV']}.sqlite"
)

require_all "app"