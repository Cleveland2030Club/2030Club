require 'spec_helper'

describe Category do
  describe "Category attributes" do
    it { should respond_to(:name) }

    context "Valid Attributes" do
      subject { Category.new }
      it { should_not be_valid }
    end

  end

  describe "Category relationships" do
    it { should respond_to(:participants) }
  end
end
