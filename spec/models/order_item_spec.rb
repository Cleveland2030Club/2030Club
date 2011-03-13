require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrderItem do
  it { should belong_to :order }
  it { should belong_to :item }
  it { should validate_numericality_of :quantity }
  message = "can only be between 1 and 100"
  it { should ensure_inclusion_of(:quantity).in_range(1..100).
                    with_low_message(message).with_high_message(message) }
end
