require 'spec_helper'

describe MembershipStatus do
  subject { described_class.new(user) }

  context "expired less than 30 days ago" do
    let(:user) { stub("user", :expired_at => 29.days.ago, :activated? => true) }
    its(:status) { should eql :expired_with_less_than_30_days }
  end

  context "expired 30 days or more ago" do
    let(:user) { stub("user", :expired_at => 30.days.ago, :activated? => true) }
    its(:status) { should eql :expired }
  end

  context "expires in 30 days or more" do
    let(:user) { stub("user", :expired_at => 31.days.from_now, :activated? => true) }
    its(:status) { should eql :current }
  end

  context "expires in less than 30 days" do
    let(:user) { stub("user", :expired_at => 30.days.from_now, :activated? => true) }
    its(:status) { should eql :current_with_less_than_30_days }
  end
end

