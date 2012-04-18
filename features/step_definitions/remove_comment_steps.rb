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
