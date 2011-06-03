ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/game_history" => "game_history#index"
   match "/kill_death_spread" => "kill_death_spread#index"
   match "/player_effectiveness" => "player_effectiveness#index"
   match "/player_effectiveness/:map_name" => "player_effectiveness#show"

   root :to => "home#index"
end
