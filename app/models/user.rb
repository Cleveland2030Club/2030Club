require 'authlogic'

class User < ActiveRecord::Base

  has_one   :current_board_position, class_name: 'BoardTerm', conditions: ["end_at > ?", Time.now]
  has_one   :user_address, dependent: :destroy
  has_one   :user_profile, dependent: :destroy

  has_many  :board_terms, dependent: :destroy
  has_many  :email_addresses
  has_many  :orders, as: :customer

  accepts_nested_attributes_for :user_profile
  accepts_nested_attributes_for :user_address

  before_save :downcase_email

  acts_as_authentic do |c|
    c.session_class = UserSession
    c.logged_in_timeout = 4.hours
    c.maintain_sessions = false
    c.validate_password_field = true
    c.perishable_token_valid_for = 5.minutes
  end

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :active,
                  :user_address_attributes, :user_profile_attributes

  scope :active, lambda { where({ active: true }) }

  attr_reader :per_page
  @@per_page = 3

  validates :first_name, :last_name, :email, presence: true

  def display_name
    "#{first_name} #{last_name}"
  end

  def avatar(style)
    user_profile ? user_profile.avatar.url(style) : "/avatars/#{style}/missing.png"
  end

  def expired?
    expired_at.nil? or expired_at < Time.now
  end

  def activate_account!
    self.activated = true
    self.active = true
    self.activated_at = Time.now
    self.joined_at = activated_at
    self.expired_at = (Time.now.utc + 1.year).end_of_month
    save!
  end

  def update_membership_expiration(time = Time.now)
    update_expiration(time)
    self.last_renewed_at = time
    save
  end

  def admin?
    current_board_position or self.email == 'jon@coffeeandcode.com'
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end

  def attendance
    return [] if orders.empty?
    user_orders = self.orders.collect do |order|
      order.events
    end
    user_orders.flatten
  end

  def self.search_active(search,date,page)
    unless date == "-" or date == nil
      active.paginate :per_page => 100, :page => page,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      active.paginate :per_page => 100, :page => page,
               :conditions => ['lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)', "%#{search}%","%#{search}%","%#{search}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    end
  end

  def self.search(search,date,page)
    unless date == "-" or date == nil
      paginate :per_page => 100, :page => page,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      paginate :per_page => 100, :page => page,
               :conditions => ['lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)', "%#{search}%","%#{search}%","%#{search}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    end
  end


  private

  def downcase_email
    self.email = self.email.downcase
  end

  def update_expiration(time)
    time = Time.parse(time) if time.is_a? String
    if membership_has_already_expired?(time)
      self.expired_at = (time.utc.midnight + 1.year).end_of_month
    else
      self.expired_at = (expired_at.midnight + 1.year).end_of_month
    end
  end

  def membership_has_already_expired?(time)
    expired_at.nil? || expired_at < time
  end

end

