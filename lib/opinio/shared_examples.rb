shared_examples_for :opinio do

  let(:comment) { Comment.new }
  let(:owner) { User.create }

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
    c.owner = owner
    c.save.should == true

    c2 = Comment.new(:body => "The Comment !")
    c2.owner = owner
    c2.commentable = c
    c2.save.should == true

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

  context "when strip_html_tags_on_save is true" do
    it "should strip html tags" do
      comment = create_valid_comment('<h1>Chuck will save us!</h1>')
      comment.body.should == 'Chuck will save us!'
    end
  end

  context "when strip_html_tags_on_save is false" do
    
    # we have to create a different class
    # because opinio adds the strip tags callbacks
    # only once when opinio is called on the class
    class NoSanitizerComment < ActiveRecord::Base
      self.table_name = :comments
    end

    before do
      Opinio.stub(:strip_html_tags_on_save).and_return(false)
      NoSanitizerComment.class_eval do
        opinio
      end
    end
    it "should not strip html tags" do
      comment = create_valid_comment('<h1>Chuck will save us!</h1>', NoSanitizerComment)
      comment.body.should == '<h1>Chuck will save us!</h1>'
    end
  end

end


shared_examples_for :opinio_subjectum do

  it "and should add opinio_subjectum functionallity" do
    should respond_to(:comments)
  end

end
