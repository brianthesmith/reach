require "active_record"

def initialize_database(config_file)
   db_config = YAML::load(File.open(config_file))
   ActiveRecord::Base.establish_connection(db_config)
   ActiveRecord::Migrator.down("db/migrate")   
   ActiveRecord::Migrator.up("db/migrate")
end


