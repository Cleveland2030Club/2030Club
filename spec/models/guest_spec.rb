require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Guest do
  context "validation" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }

    it { should allow_value("john.doe@gmail.com").for(:email) }
    it { should_not allow_value("john_gmail.com").for(:email) }
  end
end
