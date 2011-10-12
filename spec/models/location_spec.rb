require 'spec_helper'

describe Location do

  describe "Attributes" do
    it { should respond_to :region }
    it { should respond_to :address }
    it { should respond_to :address_cont }
    it { should respond_to :city }
    it { should respond_to :state }
    it { should respond_to :zip }
    it { should respond_to :phone }
  end

  describe "relationships" do
    it { should respond_to :participant }
  end

end
