require 'spec_helper'

describe Region do

  describe "Attributes" do
    it { should respond_to(:name) }
  end

  describe "Validations" do
    subject { Region.new }
    it { should_not be_valid }
  end

  describe "Relationship" do
    it "has many locations" do
      subject.should respond_to(:locations)
    end
  end

end
