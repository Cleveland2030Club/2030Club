require 'spec_helper'

describe ApplicationHelper do
  context 'current_user_expired?' do
    it 'returns true if the current_user is not set' do
      helper.stub(:current_user => nil)
      helper.current_user_expired?.should be_true
    end

    it 'returns true if the current_user is set and expired_at is nil' do
      helper.stub(:current_user => Factory.build(:user, :expired_at => nil))
      helper.current_user_expired?.should be_true
    end

    it 'returns true if the current_user is set, but expired' do
      helper.stub(:current_user => Factory.build(:user, :expired_at => Time.now - 1.day))
      helper.current_user_expired?.should be_true
    end

    it 'returns false if the current_user is set and not expired' do
      helper.stub(:current_user => Factory.build(:user, :expired_at => Time.now + 1.day))
      helper.current_user_expired?.should be_false
    end
  end
end