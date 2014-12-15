Rails.application.routes.draw do
  resources :tweet_streams, :only => [:new, :create]
end
