require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Registration do

  context "validation" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:phone_number) }

    it { should allow_value("john@gmail.com").for(:email) }
    it { should allow_value("john.doe@gmail.com").for(:email) }
    it { should_not allow_value("john_gmail.com").for(:email) }
    it { should_not allow_value("john@gmailcom").for(:email) }
    it { should_not allow_value("john@@gmail.com").for(:email) }
    
    it { should_not allow_value("p").for(:password) }

    it "validates that password and password_confirm match" do
      registration = Registration.new(:password => 'password', :password_confirmation => 'password1')
      registration.valid?.should be_false
      registration.errors[:password].should == 'and confirmation do not match'
    end
  end

end
