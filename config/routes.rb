ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/kill_death_spread" => "kill_death_spread#index"
   match "/player_effectiveness" => "player_effectiveness#index"

   root :to => "home#index"
end
