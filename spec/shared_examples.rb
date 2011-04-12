require 'spec_helper'

shared_examples_for :opinio do
  before(:all) do
    @post = Post.new(:title => "My first post", :body => "Damn I really suck at writing")
    @post.save
  end

  it "and should add opinio functionallity" do
    should respond_to(:owner)
    should respond_to(:body)
    should respond_to(:commentable)
  end

  it "and should reject comments of comments" do
    Opinio.accept_replies = true

    c = Comment.new(:body => "The Comment !")
    c.commentable = @post
    c.owner_id = 1
    c.save

    c2 = c.clone
    c2.commentable = c
    c.save.should == true

    c3 = c2.clone
    c3.commentable = c2
    c3.save.should == false

    c3.errors[:base].count.should == 1
  end

end


shared_examples_for :opinio_subjectum do

  it "and should add opinio_subjectum functionallity" do
    should respond_to(:comments)
  end

end
