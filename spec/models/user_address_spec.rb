require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserAddress do
  before(:each) do
    @user_address = FactoryGirl.build(:user_address)
  end

  it "should create a new instance given valid attributes" do
    @user_address.should be_valid
  end

  it { should belong_to :user }

  it 'will be invalid without a address' do
    @user_address.address = nil
    @user_address.should_not be_valid
  end

  it 'will be invalid without a city' do
    @user_address.city = nil
    @user_address.should_not be_valid
  end

  it 'will be invalid without a state_code' do
    @user_address.state_code = nil
    @user_address.should_not be_valid
  end

  it 'will be invalid without a zip' do
    @user_address.zip = nil
    @user_address.should_not be_valid
  end
end
