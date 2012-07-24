
def create_valid_comment(body = 'A comment', klass = Comment)
  comment = klass.new(:body => body)
  comment.owner = User.first || User.create!
  comment.commentable = create_valid_post
  comment.save
  comment
end

def create_valid_post
  Post.create!
end
