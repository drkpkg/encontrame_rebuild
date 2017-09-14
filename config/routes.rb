Rails.application.routes.draw do
  resources :publications
  root 'index#index'

  get 'signup' => 'user#signup'
  post 'signup' => 'user#signup'
  post 'signin' => 'user#signin'
  delete 'signout' => 'user#signout'
end
