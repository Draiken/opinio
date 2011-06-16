
def create_valid_comment
  comment = Comment.new(:body => 'A comment')
  comment.owner = User.first || User.create!
  comment.commentable = create_valid_post
  comment.save
  comment
end

def create_valid_post
  Post.create!
end
