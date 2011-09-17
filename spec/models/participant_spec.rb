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

end