Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root 'dashboard#index'

  resources :publications do
    get 'comment/new'
    post 'comment/create'
    put 'comment/edit'
    delete 'comment/delete'
  end
  
  scope :ab do
    
  end

end
