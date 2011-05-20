require 'active_record'

db_config = YAML::load(File.open("config/prod.yml"))
ActiveRecord::Base.establish_connection(db_config)
