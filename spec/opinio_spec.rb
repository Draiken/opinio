require 'spec_helper'

describe Opinio do

  it "should be valid module" do
    Opinio.should be_a(Module)
  end

  it "should have options" do
    Opinio.model_name.should == "Comment"
    Opinio.model_name = "Test"
    Opinio.model_name.should == "Test"
    Opinio.use_title.should == false
    Opinio.use_title = true
    Opinio.use_title.should == true
    Opinio.strip_html_tags_on_save.should == true
    Opinio.sort_order.should == "DESC"
    Opinio.set_flash.should == true
  end

  it "should accept identifiers" do
    block = Proc.new { |params|
      params[:id] == 1
    }
    Opinio.opinio_identifier(block)
    Opinio.check_custom_identifiers({:id => 1}).should == true
    Opinio.check_custom_identifiers({:id => 0}).should == false
  end

  it "should be configurable" do
    Opinio.setup do |c|
      c.model_name = "Opinion"
    end
    Opinio.model_name.should == "Opinion"
    Opinio.model_name = "Comment"
  end

  it "should accept custom destroy conditions for the opinio model" do
    user = User.new(:name => "lala")
    Opinio.set_destroy_conditions do |comment|
      comment.owner.name == "lala"
    end
    comment = Comment.new
    comment.owner = user

    comment_owned_by_someone_else = Comment.new
    comment_owned_by_someone_else.owner = User.new

    controller = ActionController::Base.new
    controller.can_destroy_opinio?(comment).should be_true
    controller.can_destroy_opinio?(comment_owned_by_someone_else).should be_false
  end

  it "should accept custom destroy conditions with a block" do
    ActionController::Base.comment_destroy_conditions do
      false
    end
    controller = ActionController::Base.new
    controller.can_destroy_opinio?(double("comment")).should be_false

    ActionController::Base.comment_destroy_conditions do
      true 
    end
    controller = ActionController::Base.new
    controller.can_destroy_opinio?(double("comment")).should be_true

  end

  it "should strip html tags on save if strip_html_tags_on_save is true" do
    comment = create_valid_comment('<h1>Chuck will save us!</h1>')
    comment.body.should == 'Chuck will save us!'
  end

  #TODO: Fixme, for some reasons test does not work
  #it "should not strip html tags on save if strip_html_tags_on_save is false" do
  #  Opinio.setup do |c|
  #    c.strip_html_tags_on_save = false
  #  end
  #  comment = create_valid_comment('<h1>Chuck will save us!</h1>')
  #  comment.body.should == '<h1>Chuck will save us!</h1>'
  #end

end
