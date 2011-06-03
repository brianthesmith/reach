require 'yaml'
require 'active_record'

config = YAML::load_file("config/database.yml")
ActiveRecord::Base.establish_connection(config["test"])
