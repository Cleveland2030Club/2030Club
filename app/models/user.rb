require 'authlogic'
require 'paperclip'
require 'lib/helper/string'

class User < ActiveRecord::Base
  has_many  :email_addresses
  has_many  :users_roles
  has_many  :roles, :through => :users_roles
  has_one   :user_profile, :dependent => :destroy
  accepts_nested_attributes_for :user_profile 
  has_one   :registration, :dependent => :destroy
  has_one   :user_address, :dependent => :destroy
  has_many  :orders, :as => :customer

  has_attached_file :avatar, 
                    :styles => { :medium => "100x100>", :thumb => "50x50" }

  acts_as_authentic do |c|
    c.session_class = UserSession
    c.logged_in_timeout = 4.hours
    c.maintain_sessions = false
    c.validate_password_field = true
    c.perishable_token_valid_for = 5.minutes
  end

  named_scope :all_members
  #named_scope :all_members, :order => :created_at
  named_scope :active_members, :conditions => ['users.id = ?', 1]

  attr_reader :per_page
  @@per_page = 3

  def avatar_file_name

  end

  def display_name
    "#{first_name} #{last_name}"
  end

  def member_since
    self.created_at
  end

  def activate_account!
    self.activated = true
    self.activated_at = Time.now
    self.joined_at = self.activated_at
    self.expired_at = Date.new(activated_at.year + 1, activated_at.month, -1)
    self.save
  end
  
  def admin?
    admins = ['morcutt@within3.com', 'kevin@detone8.com', 'agbennett1@gmail.com', 'jprovins@cleveland.com', 'julie.fratus@gmail.com', 'eljeezee@yahoo.com', 'gautpai@gmail.com', 'radinm@hotmail.com', 'montalvo.a@gmail.com', 'christinannmiller@yahoo.com', 'raablc@gmail.com', 'jessicadaiseysnyder@yahoo.com' ]
    admins.include?(self.email)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end
  
  def attendance
      user_orders = self.orders.collect do |order|
        order.events
      end
      user_orders.flatten
    
  end
  
  def self.search_active(search,date,page)
    unless date == "-" or date == nil
      paginate_all_by_active true, :per_page => 100, :page => page,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      paginate_all_by_active true, :per_page => 100, :page => page,
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
      paginate_all_by_active true, :per_page => 30000, :page => 1,
               :conditions => ['(lower(last_name) like lower(?) or lower(first_name) like lower(?) or lower(email) like lower(?)) and cast(activated_at as text) like ?', "%#{search}%","%#{search}%","%#{search}%","%#{date}%"], :order => 'Last_name ASC, first_name ASC, email ASC'
    else
      paginate_all_by_active true, :per_page => 30000, :page => 1,
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

