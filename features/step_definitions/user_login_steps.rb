PASSWORD = "password"

Given /^the following user records in the data store$/ do |table|
  clear_all_users

  table.hashes.each do |hash|
    register_user(hash)
  end
end

Given /^I have a user with the email "([^"]*)" in the data store$/ do |email|
  user = User.find_by_email(email)

  if (user == nil)
    user_hash = {"first_name" => "John", "last_name" => "Doe", 
            "email" => "jdoe@gmail.com", "password" => PASSWORD}
    user = register_user(user_hash)
  end
end

Given /^"([^"]*)" is not activated$/ do |email|
  user = User.find_by_email(email)
  user.activated = false
  user.save!
end

When /^I log in with "([^"]*)"$/ do |login|
  login_user(login, PASSWORD)
end

def login_user(email, password)
  visit new_user_session_path
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  click_button('Log In')
end

def clear_all_users
  User.delete_all
end

def register_user(hash)
  registration_converter = ConvertsRegistrationToAccountInformation.new
  
  registration = Registration.new(hash)
  registration.password_confirmation = hash["password"]

  # add address info
  user_address = Factory(:user_address)
  registration.address = user_address.address
  registration.address2 = user_address.address2
  registration.city = user_address.city
  registration.state = user_address.state_code
  registration.zip = user_address.zip

  registration_converter.do_it(registration)
  # Activate the account for now...
  user = User.find_by_email(hash["email"])
  user.activated = true
  user.save!

  user
end
