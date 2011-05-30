class ReachPlayerStat < ActiveRecord::Base
   belongs_to :reach_team
   belongs_to :player
end
