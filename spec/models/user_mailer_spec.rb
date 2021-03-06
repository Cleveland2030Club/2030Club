require 'spec_helper'

describe UserMailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = mock_model(User, :email => 'test@gmail.com')
  end

  describe "UserMailer.welcome_email" do
    before(:each) do
      FactoryGirl.create(:event, :name => 'Awesome Event', :start_at => Time.now + (7*24*60*60))
      FactoryGirl.create(:event, :name => 'Another Event', :start_at => Time.now + (14*24*60*60))
      @mailer = UserMailer.welcome_email(@user)
    end

    it "will add user email to the mailer" do
      @mailer.body.should =~ /Welcome test@gmail.com/
    end

    it "will add user logon url to the mailer" do
      @mailer.body.should =~ /http:\/\/cleveland2030.org\/login/
    end

    it "will add upcoming events to the mailer" do
      @mailer.body.should =~ /Awesome Event/
    end

    it "will deliver successfully" do
      lambda { @mailer.deliver }.should_not raise_error
    end

    it "will be added to the delivery queue" do
      lambda { @mailer.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
    end
  end

end