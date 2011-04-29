require "active_record"
require "./app/meta_data_parser"

def initialize_database(config_file)
   db_config = YAML::load(File.open(config_file))
   ActiveRecord::Base.establish_connection(db_config)
   ActiveRecord::Migrator.up("db/migrate")
   MetaDataParser.new.all_weapons
end


