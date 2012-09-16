FactoryGirl.define do
  factory :user do
    first_name 'George'
    last_name 'Plate'
    url_friendly 'george_plate'
    email 'jdoe@gmail.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :active_user, :parent=>:user do
    expired_at Date.today + 1.year
  end
end
