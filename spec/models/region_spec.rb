require 'spec_helper'

describe Region do

  describe "Attributes" do
    it { should respond_to(:name) }
  end

  describe "Validations" do
    subject { Region.new }

    it "requires a name" do
      subject.should_not be_valid
    end

    it "names must be unique" do
      subject.name = "Recreation"
      subject.save
      new_region = Region.new(:name => "Recreation")
      new_region.should_not be_valid
    end

  end

  describe "Relationship" do
    it "has many locations" do
      subject.should respond_to(:locations)
    end
  end

end
