require 'rubygems'
require 'halo-reach-api'

class ReachClient
   def initialize
      api_key = File.new("resources/api_key.txt").read.chomp
      @reach = Halo::Reach::API.new(api_key)
   end

   def pull_data
      @reach.woot
   end
end
