module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^I visit a page with comments$/ do
  post = Post.new(:title => "A post", :body => "A post's body")
  post.save
  u = User.new :name => "Tester2"
  assert u.save
  20.times do |n|
    c = Comment.new :body => "comment number #{n}"
    c.owner = u
    c.commentable = post
    c.save
  end
  page.visit "/posts/#{post.id}"
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^press "([^"]*)"$/ do |arg1|
  click_button arg1
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
