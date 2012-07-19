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
    context "with a valid comment" do
      it "creates successfully" do
        post :create,
             :comment => { :body => 'A comment' },
             :commentable_id => @post.id,
             :commentable_type => 'Post'
        
        response.should redirect_to( post_path(@post) )
        flash[:notice].should be_present 
      end
    end

    context "with an invalid comment" do
      it "should redirect back with an error" do
        post :create,
          :comment => { :body => nil },
          :commentable_id => @post.id,
          :commentable_type => 'Post'

        response.should redirect_to( post_path(@post) )
        flash[:error].should be_present 
      end
    end

    context "with an AJAX request" do
      it "should create and return javascript" do
        post :create,
             :comment => { :body => 'A comment' },
             :commentable_id => @post.id,
             :commentable_type => 'Post',
             :format => :js

        response.headers["Content-Type"].should =~ /text\/javascript/
        flash[:notice].should_not be_present 
        response.should be_success
      end
    end

    context "with a different opinio_after_create_path" do

      before do
        subject.stub(:opinio_after_create_path).and_return(root_path)
      end

      it "should redirect to the set path" do
        post :create,
             :comment => { :body => 'A comment' },
             :commentable_id => @post.id,
             :commentable_type => 'Post'
        
        response.should redirect_to( root_path )
      end
    end
  end

  describe "GET reply" do
    context "with a javascript request" do
      it "should return javascript" do
        get :reply,
            :id => create_valid_comment.id,
            :format => :js
            
        response.headers["Content-Type"].should =~ /text\/javascript/
        response.should be_success
      end
    end
  end

  describe "DELETE destroy" do

    before do
      Opinio.set_destroy_conditions do
        true
      end
    end

    context "with an HTML request" do
      it "should remove the comment" do
        comment = create_valid_comment
        delete :destroy,
               :id => comment.id

        response.should redirect_to( post_path(comment.commentable) )
        flash[:error].should_not be_present
      end
    end

    context "with a javascript request" do
      it "should remove the comment" do
        comment = create_valid_comment
        delete :destroy,
               :id => comment.id,
               :format => :js

        response.should be_success 
        response.headers["Content-Type"].should =~ /text\/javascript/
        flash[:error].should_not be_present
      end
    end

    context "with a different opinio_after_destroy_path" do

      before do
        subject.stub(:opinio_after_destroy_path).and_return(root_path)
      end

      it "should redirect to the set path" do
        comment = create_valid_comment

        delete :destroy,
               :id => comment.id

        response.should redirect_to( root_path )
      end
    end
  end

  describe "setting the flash" do

    context "when 'set_flash' option is false" do
      before do
        Opinio.stub(:set_flash).and_return(false)
      end

      it "should not set the flash" do
        post :create,
             :comment => { :body => 'A comment' },
             :commentable_id => @post.id,
             :commentable_type => 'Post'
        
        response.should redirect_to( post_path(@post) )
        flash[:notice].should_not be_present 
      end
    end

    context "when 'set_flash' option is true" do
      it "should set the flash" do
        post :create,
             :comment => { :body => 'A comment' },
             :commentable_id => @post.id,
             :commentable_type => 'Post'
        
        response.should redirect_to( post_path(@post) )
        flash[:notice].should be_present 
      end
    end

  end

end
