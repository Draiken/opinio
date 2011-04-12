Rails.application.routes.draw do
  resources :comments, :controller => 'opinio/comments' do
    get 'reply', :on => :member
  end
end
