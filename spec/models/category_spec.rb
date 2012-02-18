require 'spec_helper'

describe Category do
  describe "Category attributes" do
    it { should respond_to(:name) }

    context "Valid Attributes" do
      subject { Category.new }

      it "requires a name" do
        subject.should_not be_valid
      end

      it "only allows unique values for the name" do
        subject.name = "Arts and Culture"
        subject.save
        new_category = Category.new(:name => "Arts and Culture")
        new_category.should_not be_valid
      end
    end

  end

  describe "Category relationships" do
    it { should respond_to(:participants) }
  end
end
