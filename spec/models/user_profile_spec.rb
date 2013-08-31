require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserProfile do
  before(:each) do
    @user_profile = FactoryGirl.build(:user_profile)
  end

  it 'will create a new instance given valid attributes' do
    @user_profile.should be_valid
  end

  it { should belong_to :user }

  it 'will be valid with an empty phone number' do
    @user_profile.phone_number = ''
    @user_profile.should be_valid
  end

  it 'will be invalid with an phone number length greater than 255' do
    @user_profile.phone_number = '*' * 256
    @user_profile.should_not be_valid
  end
end
