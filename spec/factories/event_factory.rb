Factory.define :event do |f|
  f.name 'Test'
  f.start_at Time.now
  f.end_at Time.now + 1.hour
  f.after_build do |event|
    event.items = [Item.new(:price => 0, :name => Event::PRICE_TYPES[:standard], :product => event),
                   Item.new(:price => 0, :name => Event::PRICE_TYPES[:club], :product => event)]
  end
end

Factory.define :free_event, :parent => :event do |f|
  f.after_build do |event|
    event.items = [Item.new(:price => 0, :name => Event::PRICE_TYPES[:standard], :product => event),
                   Item.new(:price => 0, :name => Event::PRICE_TYPES[:club], :product => event)]
  end
end

Factory.define :paid_event, :parent => :event do |f|
  f.after_build do |event|
    event.items = [Item.new(:price => 10, :name => Event::PRICE_TYPES[:standard], :product => event),
                   Item.new(:price => 5, :name => Event::PRICE_TYPES[:club], :product => event)]
  end
end
