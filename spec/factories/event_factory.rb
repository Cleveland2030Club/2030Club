Factory.define :event do |f|
  f.name 'Test'
  f.after_build do |event|
    event.items = [Item.new(:price => 0, :name => Event::PRICE_TYPES[:standard], :product => event),
                   Item.new(:price => 0, :name => Event::PRICE_TYPES[:club], :product => event)]
  end
end
