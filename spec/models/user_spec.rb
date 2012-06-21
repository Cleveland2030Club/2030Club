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
    user.expired_at.should == (Time.now.end_of_month + 1.year)
  end

  describe "#update_membership_expiration" do
    context "When the user's membership has already expired" do
      it "set the new expiration date to 1 year from today and the end of the month" do
        @user.expired_at = (Time.now - 60.days).end_of_month
        @user.save

        @user.update_membership_expiration
        @user.expired_at.should == (Time.now.end_of_month + 1.year)
      end
    end
    context "When the user's membership is still active" do
      it "set the new expiration date to 1 year from the current expiration date" do
        time = (Time.now + 60.days).end_of_month
        @user.expired_at = time
        @user.save

        @user.update_membership_expiration
        @user.expired_at.should == (time + 1.year)
      end
    end
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

  describe '#avatar(style)' do
    before :each do
      @user = Factory.build(:user)
    end

    context "with a user_profile" do
      it "returns the avatar url for the profile" do
        @user.user_profile = UserProfile.new
        @user.user_profile.should_receive(:avatar).and_return(double("Avatar").as_null_object)
        @user.avatar(:thumb)
      end
    end

    context "without a user_profile" do
      it "returns the url for the default image" do
        @user.avatar(:thumb).should == "/avatars/thumb/missing.png"
      end
    end
  end
end
