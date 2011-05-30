class ReachTeam < ActiveRecord::Base
   belongs_to :reach_game

   has_many :reach_player_stats
end
