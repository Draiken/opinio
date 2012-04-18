When /^I choose to reply a comment$/ do
  within "#comments li:first-child" do
    page.click_link "Reply"
  end
end

When /^I send the reply$/ do
  @message = "This is a reply"
  send_comment(@message)
end

Then /^I should see my reply$/ do
  within '.replies' do
    page.should have_content(@message)
  end
end
