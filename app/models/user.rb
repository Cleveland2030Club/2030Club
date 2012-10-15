require 'authlogic'

class User < ActiveRecord::Base
  has_many  :email_addresses
  has_many  :users_roles
  has_many  :roles, :through => :users_roles
  has_one   :user_profile, :dependent => :destroy
  accepts_nested_attributes_for :user_profile
  has_one   :registration, :dependent => :destroy
  has_one   :user_address, :dependent => :destroy
  accepts_nested_attributes_for :user_address
  has_many  :orders, :as => :customer

  acts_as_authentic do |c|
    c.session_class = UserSession
    c.logged_in_timeout = 4.hours
    c.maintain_sessions = false
    c.validate_password_field = true
    c.perishable_token_valid_for = 5.minutes
  end

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :active
  attr_accessible :user_address_attributes, :user_profile_attributes

  scope :all_members
  scope :active, -> { where({ active: true }) }

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

  def member_since
    self.created_at
  end

  def activate_account!
    self.activated = true
    self.active = true
    self.activated_at = Time.now
    self.joined_at = self.activated_at
    self.expired_at = Time.now.end_of_month + 1.year
    self.save
  end

  def update_membership_expiration
    if self.expired_at < Time.now
      self.expired_at = (Time.now.end_of_month + 1.year)
      self.last_renewed_at = Time.now
      self.save
    else
      self.expired_at = (self.expired_at + 1.year)
      self.last_renewed_at = Time.now
      self.save
    end
  end

  def admin?
    admins = ['jon@coffeeandcode.com',
              'kevin@detone8.com',
              'gautpai@gmail.com',
              'raablc@gmail.com',
              'j.scott645@gmail.com',
              'efig8503@yahoo.com',
              'walker.1138@gmail.com',
              'james.schleicher@wslife.com',
              'leia.bradford@gmail.com',
              'tderosa7@gmail.com',
              'sireleo@gmail.com'
              ]
    admins.include?(self.email)
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

  def self.csv_search_active(search,date)
    unless date == "-" or date == nil
      active.paginate true, :per_page => 30000, :page => 1,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      active.paginate true, :per_page => 30000, :page => 1,
               :conditions => ['lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)', "%#{search}%","%#{search}%","%#{search}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    end
  end

  def self.csv_search(search,date)
    unless date == "-" or date == nil
      paginate :per_page => 30000, :page => 1,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      paginate :per_page => 30000, :page => 1,
               :conditions => ['lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)', "%#{search}%","%#{search}%","%#{search}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    end
  end

end

