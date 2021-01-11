Rails.application.routes.draw do

  get 'auth/google_oauth2/callback', to: 'sessions#omniauth'

  namespace :api do
    namespace :v1 do
      resources :users
      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end
  end
end
