Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'sessions'}
  get "welcome/index"
  get '/verify' => 'verify#edit', as: 'verify'
  get '/verify' => 'verify#new', as: 'new_verify'
  put '/verify' => 'verify#update', as: 'update_verify'
  post '/verify' => 'verify#create', as: 'resend_verify'

  root "welcome#index"
end
