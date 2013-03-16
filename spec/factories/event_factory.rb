FactoryGirl.define do
  factory :event do
    name 'Test'
    start_at Time.now
    end_at Time.now + 1.hour
    max_attendance 50
    after(:build) do |event|
      event.items = [Item.new(:price => 0, :name => Event::PRICE_TYPES[:standard], :product => event),
                     Item.new(:price => 0, :name => Event::PRICE_TYPES[:club], :product => event)]
    end
  end

  factory :free_event, :parent => :event do
    after(:build) do |event|
      event.items = [Item.new(:price => 0, :name => Event::PRICE_TYPES[:standard], :product => event),
                     Item.new(:price => 0, :name => Event::PRICE_TYPES[:club], :product => event)]
    end
  end

  factory :paid_event, :parent => :event do
    after(:build) do |event|
      event.items = [Item.new(:price => 10, :name => Event::PRICE_TYPES[:standard], :product => event),
                     Item.new(:price => 5, :name => Event::PRICE_TYPES[:club], :product => event)]
    end
  end
end
