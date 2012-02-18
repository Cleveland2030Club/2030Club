require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = Factory.build(:user)
  end

  it { should have_one :user_profile }
  it { should have_one :registration }
  it "User#admin? returns true if user has been declared an admin" do
    @user.email = 'kevin@detone8.com'
    @user.admin?.should be_true
  end
  
  it "activates a user account" do
    time = Time.now
    Time.stub!(:now).and_return(time)
    user = User.new
    user.stub!(:save)

    user.activate_account!

    user.should be_activated
    user.activated_at.should == time
    user.joined_at.should == time
    user.expired_at.should == DateTime.new(user.activated_at.year + 1, user.activated_at.month, -1)
  end
end
