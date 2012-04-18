Then /^I should see the comments$/ do
  within "#comments" do
    page.should have_content("comment number")
  end
end

When /^I use the pagination$/ do
  page.click_link("2")
end

Then /^I should see more comments$/ do
  within "#comments" do
    page.should have_content("comment number 13")
  end
end

When /^I send a comment$/ do
  @message = "I love to comment"
  send_comment(@message)
end

Then /^I should see the comment I've sent$/ do
  within "#comments" do
    page.should have_content(@message)
  end
end

def send_comment(message)
  within "#new_comment" do
    fill_in "comment_body", :with => message 
    click_button "Add comment"
  end
end
