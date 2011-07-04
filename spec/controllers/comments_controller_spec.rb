require 'spec_helper'

describe Opinio::CommentsController do

  before(:all) do
    @post = create_valid_post 
  end

  describe "GET index" do
    it "shows the comment of a resource with extra parameters" do
      get :index,
          :commentable_id => @post.id,
          :commentable_type => 'Post'

      response.should be_success
      assigns(:comments).should_not be_nil
    end

    it "shows the comment of a resource without extra parameters" do
      get :index,
          :post_id => @post.id

      response.should be_success
      assigns(:comments).should_not be_nil
    end
  end

  describe "POST create" do
    it "creates a comment" do
      post :create,
           :comment => { :body => 'A comment' },
           :commentable_id => @post.id,
           :commentable_type => 'Post'
      
      response.should redirect_to( post_path(@post) )
      flash[:notice].should be_present 
    end

    it "creates a comment with ajax" do
      post :create,
           :comment => { :body => 'A comment' },
           :commentable_id => @post.id,
           :commentable_type => 'Post',
           :format => :js

      response.headers["Content-Type"].should =~ /text\/javascript/
      flash[:notice].should be_present 
      response.should be_success
    end
  end

  describe "GET reply" do
    it "should return javascript" do
      get :reply,
          :id => create_valid_comment.id,
          :format => :js
          
      response.headers["Content-Type"].should =~ /text\/javascript/
      response.should be_success
    end
  end

  describe "DELETE destroy" do

    before do
      Opinio.set_destroy_conditions do
        true
      end
    end

    it "should remove the comment" do
      comment = create_valid_comment
      delete :destroy,
             :id => comment.id

      response.should redirect_to( post_path(comment.commentable) )
      flash[:error].should_not be_present
    end

    it "should remove the comment with javascript" do
      comment = create_valid_comment
      delete :destroy,
             :id => comment.id,
             :format => :js

      response.should be_success 
      response.headers["Content-Type"].should =~ /text\/javascript/
      flash[:error].should_not be_present
    end
  end

end
