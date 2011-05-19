ReachWeb::Application.routes.draw do
   match "/home" => "home#index"

   match "/average_deaths" => "average_deaths#index"
   match "/average_kills" => "average_kills#index"
   match "/average_spread" => "average_spread#index"

   root :to => "home#index"
end
