
desc "Fetch stats from service and populate database with results"
task :run_batch_job do
   config = YAML::load(File.open("config/database.yml"))
   ActiveRecord::Base.establish_connection(config["production"])   
   ActiveRecord::Migrator.migrate("db/migrate")
   sh "ruby -Ilib lib/batch_job.rb"
end
