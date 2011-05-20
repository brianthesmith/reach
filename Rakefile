# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

ReachWeb::Application.load_tasks


def environment(env)
   ActiveRecord::Base.establish_connection(YAML::load(File.open("config/#{env}.yml")))   
   ActiveRecord::Migrator.migrate("db/migrate")
end

desc "Run batch job"
task :run_batch_job do
   environment(:prod)
   sh "ruby -Ilib lib/batch_job.rb"
end

desc "Run update job"
task :run_update_job do
   environment(:prod)
   sh "ruby -Ilib lib/update_job.rb"
end

