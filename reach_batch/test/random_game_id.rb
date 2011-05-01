def random_game_id
   o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
   string  =  (0..50).map{ o[rand(o.length)]  }.join;
end
