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
  
  describe "Participant relationships" do
    it { should respond_to(:category) }
    it { should respond_to(:locations) }
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

  describe "#regions" do

    subject { Participant.create(:name => "Participant", :bio => "bio", :benefit => "benefit", :instructions => "instruction") }

    it "Returns an array of regions for the participants locations" do
      region1 = Region.create(:name => "Region 1")
      region2 = Region.create(:name => "Region 2")
      subject.locations.build(:address => "123 Main St", :region_id => region1.id)
      subject.locations.build(:address => "456 Main St", :region_id => region2.id)

      subject.regions.should == ["Region 1", "Region 2"]
    end
  end
end
