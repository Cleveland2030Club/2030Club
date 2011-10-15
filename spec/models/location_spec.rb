require 'spec_helper'

describe Location do

  describe "Attributes" do
    it { should respond_to :address }
    it { should respond_to :address_cont }
    it { should respond_to :city }
    it { should respond_to :state }
    it { should respond_to :zip }
    it { should respond_to :phone }
    it { should respond_to :google_map_link }
  end

  describe "relationships" do
    it "belongs to participant" do
      subject.should respond_to(:participant)
    end
    it "belongs to region" do
      subject.should respond_to(:region)
    end
  end

end
