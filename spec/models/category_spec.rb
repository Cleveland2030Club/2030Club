require 'spec_helper'

describe Category do
  describe "Category attributes" do
    it { should respond_to(:name) }
  end
  
  describe "Category relationships" do
    it { should respond_to(:participants) }
  end
end