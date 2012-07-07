class Registration < ActiveRecord::Base

  belongs_to :account

  attr_accessor :password
  attr_accessor :password_confirmation

  attr_writer :current_step

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
                  :address, :address2, :city, :state, :zip, :phone_number, :profession,
                  :employer, :education, :about2030
  
  validates_presence_of :first_name, :last_name, :email,
    :password, :password_confirmation, :address, :city, :state, :zip, :phone_number
  validates_format_of :email,
    :with => RegistrationsHelper::EMAIL_REGEX,
    :if => :email?

  def password?
    return true unless @password == nil || @password.strip == ''
    false
  end

  def validate
    errors.add('password', 'and confirmation do not match') unless password_confirmation == password
  end
end

