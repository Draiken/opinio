require 'spec_helper'

describe Opinio do
  it "should be valid module" do
    Opinio.should be_a(Module)
  end

  it "Should have options" do
    Opinio.model_name.should == "Comment"
    Opinio.model_name = "Test"
    Opinio.model_name.should == "Test"
    Opinio.use_title.should == false
    Opinio.use_title = true
    Opinio.use_title.should == true
  end

  it "Should accept identifiers" do
    block = Proc.new { |params|
      params[:id] == 1
    }
    Opinio.opinio_identifier(block)
    Opinio.check_custom_identifiers({:id => 1}).should == true
    Opinio.check_custom_identifiers({:id => 0}).should == false
  end

  it "Should be configurable" do
    Opinio.setup do |c|
      c.model_name = "Opinion"
    end
    Opinio.model_name.should == "Opinion"
  end
end
