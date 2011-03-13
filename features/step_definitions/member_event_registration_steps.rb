Given /^I am logged in as a member$/ do
  hash = { "first_name" => "John", "last_name" => "Doe", "email" => "jdoe@gmail.com", 
           "password" => "password", "password_confirmation" => "password"}
  register_user(hash)
  login_user(hash["email"], hash["password"])
end

Given /^I have an event named "([^"]*)" with standard price of "([^"]*)" and club price of "([^"]*)"$/ do |name, standard_price, club_price|
  event = Event.create(:name => name, :standard_price => standard_price.to_i, 
                       :club_price => club_price.to_i, :start_at => Time.now, 
                       :end_at => Time.now.advance(:minutes => 30))
end
