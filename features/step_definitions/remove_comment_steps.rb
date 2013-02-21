Given /^I have sent a comment$/ do
  post = Post.new :title => "The post", :body => "The body of the post!"
  post.save
  @user = User.new :name => "Mr. User"
  @user.save
  @comment = Comment.new :body => "I love to comment"
  @comment.owner = @user
  @comment.commentable = post
  @comment.save

  visit(set_current_user_path(@user))

  visit(post_path(@comment.commentable)) 
end

When /^I remove that comment$/ do
  # forces any comment to be destroyed by anyone
  Opinio.set_destroy_conditions do
    true
  end

  within("#comment_#{@comment.id}") do
    click_link 'Delete'
  end
end

Then /^I should see a message confirming I removed it$/ do
  page.should have_content("Comment removed")
end

Then /^I should not see my comment$/ do
  page.should_not have_content(@comment.body)
end

Given /^someone else have sent a comment$/ do
  post = Post.create :title => "The post", :body => "The body of the post!"
  user = User.create :name => "Mr. User"
  logged_user = User.create :name => "Myself"
  visit(set_current_user_path(logged_user))
  @comment = Comment.new :body => "I love to comment"
  @comment.owner = user
  @comment.commentable = post
  @comment.save
end

When /^I see the comment$/ do
  visit(post_path(@comment.commentable))
end

Then /^I should not be able to delete it$/ do
  page.should have_no_content("Deletar")
end
