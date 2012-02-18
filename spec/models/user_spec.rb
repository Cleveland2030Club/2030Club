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

  context 'expiration' do
    it 'returns true when user expired_at is before today' do
      @user.expired_at = Time.now - 1.day
      @user.expired?.should be_true
    end

    it 'returns false when user expired_at is after today' do
      @user.expired_at = Time.now + 1.day
      @user.expired?.should be_false
    end

    it 'returns true when user expired_at is nil' do
      @user.expired_at = nil
      @user.expired?.should be_true
    end
  end
end
