Rails.application.routes.draw do
  root "tweet_streams#new"
  resources :tweet_streams, :only => [:new, :create]
end
