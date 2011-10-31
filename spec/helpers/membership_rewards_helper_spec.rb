require 'spec_helper'

describe MembershipRewardsHelper do

  describe "#format_participant_url(participant)" do
    it "returns the participant url if the particpant url includes http" do
      participant = Participant.new(:url => 'http://www.cleveland2030.org')
      helper.format_participant_url(participant).should == participant.url
    end
    it "returns the participant url prepended with http: if the particpant url does not includes http" do
      participant = Participant.new(:url => 'cleveland2030.org')
      helper.format_participant_url(participant).should == "http://#{participant.url}"
    end
  end

  describe "#region_display(participant)" do
    it "returns collection of urls for the participant" do
      region = Region.new(:name => "Coventry")
      participant = Participant.new
      participant.stub(:regions).and_return([region])
      helper.region_display(participant).should == "<a href=\"/membership_rewards/regions\">Coventry</a>"
    end
  end

end