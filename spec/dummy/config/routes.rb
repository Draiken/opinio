Dummy::Application.routes.draw do
  resources :users
  get 'set_current_user/:id' => 'application#set_current_user', :as => :set_current_user

  opinio_model

  resources :posts do
    opinio 'comments'
  end

  root :to => "users#index"
end
