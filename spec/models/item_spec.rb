require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  it { should belong_to :product }
  it { should have_many :orders }
end
