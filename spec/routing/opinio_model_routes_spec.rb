require 'spec_helper'

describe "Routing to comments controller" do
  
  it "routes POST /comments to opinio/comments#create" do
    { :post => '/comments' }.should route_to(
      :controller => 'opinio/comments',
      :action => 'create'
    )
  end

  it "routes DELETE /comments/:id to opinio/comments#destroy" do
    { :delete => "/comments/1/" }.should route_to(
      :controller => 'opinio/comments',
      :action => 'destroy',
      :id => '1'
    )
  end

  it "routes GET /comments/:id/reply to opinio/comments#reply" do
    { :get => "/comments/1/reply" }.should route_to(
      :controller => 'opinio/comments',
      :action => 'reply',
      :id => '1'
    )
  end

  #  resources :post do
  #    opinio
  #  end
  it "routes GET /posts/1/comments/ to opinio/comments#index" do
    { :get => "/posts/1/comments/" }.should route_to(
      :controller => 'opinio/comments',
      :action => 'index',
      :post_id => '1'
    )
  end
end
