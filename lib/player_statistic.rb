require 'active_record'

class PlayerStatistic < ActiveRecord::Base
   belongs_to :player
end
