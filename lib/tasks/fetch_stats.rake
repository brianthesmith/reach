require "yaml"
require "active_record"

require "batch_job"

desc "Fetch stats from service and populate database with results"
task :run_batch_job => :environment do
   ENV["RAILS_ENV"] ||= "production"

   config = YAML::load(File.open("config/database.yml"))
   ActiveRecord::Base.establish_connection(config["production"])   
   ActiveRecord::Migrator.migrate("db/migrate")

   BatchJob.new.execute
end
