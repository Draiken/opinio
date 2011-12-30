shared_examples_for :opinio do
  let(:comment) { Comment.new }
  before(:all) do
    @post = Post.new(:title => "My first post", :body => "Damn I really suck at writing")
    @post.save
  end

  it "should have the correct attributes" do
    should respond_to(:owner)
    should respond_to(:body)
    should respond_to(:commentable)
  end


  it "should not allow comments of comments" do
    Comment.class_eval do
      include Opinio::OpinioModel::RepliesSupport
    end

    c = Comment.new(:body => "The Comment !")
    c.commentable = @post
    c.owner_id = 1
    c.save

    c2 = c.dup
    c2.commentable = c
    c.save.should == true

    c3 = c2.dup
    c3.commentable = c2
    c3.save.should == false

    c3.errors[:base].count.should == 1
  end

  it "should validate presence of body and commentable" do
    comment.should be_invalid
    comment.errors[:body].should be_present
    comment.errors[:commentable].should be_present
  end

  it "and it should insist on having an owner" do
    c = Comment.new(:body => "The Comment !")
    c.commentable = @post
    c.save.should == false
  end

end


shared_examples_for :opinio_subjectum do

  it "and should add opinio_subjectum functionallity" do
    should respond_to(:comments)
  end

end
