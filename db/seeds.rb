# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

states = [
    [ "Alabama", "AL" ], [ "Alaska", "AK" ], [ "Arizona", "AZ" ], [ "Arkansas", "AR" ],
    [ "California", "CA" ], [ "Colorado", "CO" ], [ "Connecticut", "CT" ], [ "Delaware", "DE" ],
    [ "District Of Columbia", "DC" ], [ "Florida", "FL" ], [ "Georgia", "GA" ], [ "Hawaii", "HI" ],
    [ "Idaho", "ID" ], [ "Illinois", "IL" ], [ "Indiana", "IN" ], [ "Iowa", "IA" ],
    [ "Kansas", "KS" ], [ "Kentucky", "KY" ], [ "Louisiana", "LA" ], [ "Maine", "ME" ],
    [ "Maryland", "MD" ], [ "Massachusetts", "MA" ], [ "Michigan", "MI" ], [ "Minnesota", "MN" ],
    [ "Mississippi", "MS" ], [ "Missouri", "MO" ], [ "Montana", "MT" ], [ "Nebraska", "NE" ],
    [ "Nevada", "NV" ], [ "New Hampshire", "NH" ], [ "New Jersey", "NJ" ], [ "New Mexico", "NM" ],
    [ "New York", "NY" ], [ "North Carolina", "NC" ], [ "North Dakota", "ND" ], [ "Ohio", "OH" ],
    [ "Oklahoma", "OK" ], [ "Oregon", "OR" ], [ "Pennsylvania", "PA" ], [ "Rhode Island", "RI" ],
    [ "South Carolina", "SC" ], [ "South Dakota", "SD" ], [ "Tennessee", "TN" ], [ "Texas", "TX" ],
    [ "Utah", "UT" ], [ "Vermont", "VT" ], [ "Virginia", "VA" ], [ "Washington", "WA" ],
    [ "West Virginia", "WV" ], [ "Wisconsin", "WI" ], [ "Wyoming", "WY" ] ]

states.each{ |state| State.create(:title => state[0], :code => state[1]) }

# Standard membership item
membership = Membership.create(:name => 'Standard')
Item.create(:name => 'New Membership', :price => 75, :product => membership)
Item.create(:name => 'Early Renewal', :price => 50, :product => membership) #Renewing membership before expiration
Item.create(:name => 'Grace Period Renewal', :price => 50, :product => membership) # Renew withing 30 of expiration
Item.create(:name => 'Late Renewal', :price => 75, :product => membership) #Renew more than 30 days after expiration date

def create_items_for_event(standard_price = 0, club_price = 0)
  [Item.new(:price => standard_price, :name => Event::PRICE_TYPES[:standard]),
   Item.new(:price => club_price, :name => Event::PRICE_TYPES[:club])]
end

=begin
events = Event.create([
  {:name => "National City Night on the Town",
  :start_at => Time.now.advance(:days => 5),
	:end_at => Time.now.advance(:days =>5, :minutes => 30),
  :sponsored => true,
  :items => create_items_for_event
   },
   {:name => "Great Lakes Brewery...",
     :start_at => Time.now.advance(:days => 8),
     :end_at => Time.now.advance(:days => 8, :minutes => 30),
     :sponsored => true,
     :items => create_items_for_event
   },
   {:name => "Hackibou",
     :start_at => Time.now.advance(:days => 20),
     :end_at => Time.now.advance(:days => 20, :minutes => 30),
     :sponsored => true,
     :items => create_items_for_event(25, 15)
   },
    {:name => "Clerb",
     :start_at => Time.now.advance(:days => 6),
     :end_at => Time.now.advance(:days => 6, :minutes => 30),
     :sponsored => false,
     :items => create_items_for_event
   }])

# Temp User - we'll remove it later
def create_registered_user(first_name, email)
  registration = Registration.new(:first_name => first_name, :last_name => 'Doe', :email => email,
    :password => 'password', :password_confirmation => 'password', :address => '3600 Cedar Road',
    :city => 'Shaker Heights', :state => 'OH', :zip => '44390', :phone_number => '216-890-5543')
  registration_converter = ConvertsRegistrationToAccountInformation.new
  user = registration_converter.do_it(registration)
  user.save!
  user.activate_account!
end

create_registered_user('John', 'johndoe@gmail.com')
(1..5).each { |n| create_registered_user("John #{n}", "john#{n}doe@gmail.com") }
=end
