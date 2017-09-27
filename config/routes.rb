Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root 'dashboard#index'

  resources :publications do
    get 'comment/new'
    post 'comment/create'
    put 'comment/edit'
    delete 'comment/delete'
  end
  
  scope :api do
    scope :v1 do
      scope :user do
        post 'login' => 'api#user_login'
        post 'create' => 'api#user_create'
      end
      scope :publications do
        get   '/' => 'api#publication_all'
        post  'create' => 'api#publication_create'
        get   ':publication_id' => 'api#publication_info'
        put   ':publication_id/modify' => 'api#publication_modify'
        delete ':publication_id/delete' => 'api#publication_delete'
      end
    end
  end

end
