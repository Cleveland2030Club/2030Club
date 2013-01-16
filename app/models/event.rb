class Event < ActiveRecord::Base
  attr_accessible :name, :start_at, :end_at, :description, :sponsored, :club_price, :standard_price, :max_attendance, :active

  PRICE_TYPES = {
    :standard => 'Standard price',
    :club => 'Club price'}

  has_event_calendar
  has_attached_file :sponsor, :styles => {:thumb => "100"}, :default_url => '/images/blank.gif'
  has_many :items, :as => :product
  accepts_nested_attributes_for :items

  scope :with_sponsor, where(:sponsored => true)
  scope :coming_soon, where(['start_at BETWEEN ? AND ?',
                             Time.now, Time.now.advance(:days =>14)]).
                             order("start_at ASC")

  validates :max_attendance, presence: true

  def active?
    Time.now < end_at
  end

  #Method used to see if the member should rsvp or register for an event
  def club_price_item
    get_item(PRICE_TYPES[:club])
  end

  def club_price
    get_price_from_items(PRICE_TYPES[:club])
  end

  def club_price=(value)
    set_price_for_item(PRICE_TYPES[:club], value)
  end

  def standard_price_item
    get_item(PRICE_TYPES[:standard])
  end

  def standard_price
    get_price_from_items(PRICE_TYPES[:standard])
  end

  def standard_price=(value)
    set_price_for_item(PRICE_TYPES[:standard], value)
  end

  def member_rsvp?
    club_price == 0
  end

  def guest_rsvp?
    standard_price == 0
  end

  def get_view_mode(current_user)
    return "member_rsvp" if current_user && club_price == 0
    return "member_registration" if current_user && !current_user.expired? && club_price > 0
    return "/shared/guest_rsvp" if (current_user.nil? || current_user.expired?) && standard_price == 0
    return "/shared/guest_registration" if (current_user.nil? || current_user.expired?) && standard_price > 0
  end

  def get_price(current_user)
    if current_user
        club_price
    else
      standard_price
    end
  end

  def attendees
    # This is nasty must refactor
    items = Item.includes(:order_items).where(product_type: 'Event', product_id: self.id)
    order_items = OrderItem.includes(:order).where(item_id: items)
    orders = order_items.map{|oi| oi.order }
    orders.select!{ |o| o.complete? }
    customers = orders.map{|o| o.customer }
  end

  def increment_attendee_count
    self.attendee_count += 1
    self.save
  end

  def full?
    return attendee_count >= max_attendance
  end

private

  def get_item(name)
    result = items.select{ |i| i.name == name}
    return result[0] if result.length == 1
    nil
  end

  def get_price_from_items(price_name)
    result = get_item(price_name)
    return 0 if result == nil
    return result.price
  end

  def set_price_for_item(price_name, value)
    result = get_item(price_name)
    result.price = value and return if result != nil

    items << Item.new(:name => price_name, :price => value)
  end


end
