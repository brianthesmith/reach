class ReachGame < ActiveRecord::Base
   belongs_to :reach_map
   has_many :reach_teams

   def self.find_by_reach_id(id)
      where(:reach_id  => id).first
   end
end
