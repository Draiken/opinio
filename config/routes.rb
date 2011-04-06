Rails.application.routes.draw do
  resources :comments, :controller => 'opinio/comments', :path => '/comments'
end
