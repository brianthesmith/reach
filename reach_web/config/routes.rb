ReachWeb::Application.routes.draw do

   match "/average_deaths" => "average_deaths#index"

   root :to => "home#index"

end
