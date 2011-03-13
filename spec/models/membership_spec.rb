require File.dirname(__FILE__) + '/../spec_helper'

describe Membership do
  it { should have_many :items }

  it "includes memberships with Standard name" do
    membership = Membership.create! :name => 'Standard'
    Membership.standard.should include(membership)
  end

  it "excludes memberships without the Standard name" do
    membership = Membership.create! :name => 'Some membership'
    Membership.standard.should_not include(membership)
  end
end
