require 'spec_helper'

describe Participant do
  
  describe "Particpant attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:url) }
    it { should respond_to(:bio) }
    it { should respond_to(:benefit) }
    it { should respond_to(:instructions) }
    it { should respond_to(:logo) }
  end

  describe "a valid Participant requires" do
    before do
      @participant = Participant.new(:name => "Company", :url => "http://company.com",
        :bio => "Hello World", :benefit => "Discount goes here", :instructions => "How to redeem")
    end
    
    it "a name" do
      @participant.name = ""
      @participant.should_not be_valid
    end
    
    it "a bio" do
      @participant.bio = ""
      @participant.should_not be_valid
    end
    
    it "a benefit" do
      @participant.benefit = ""
      @participant.should_not be_valid
    end
    
    it "instructions" do
      @participant.instructions = ""
      @participant.should_not be_valid
    end
  end
end