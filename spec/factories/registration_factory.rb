FactoryGirl.define do
  factory :registration do
    first_name 'John'
    last_name 'Doe'
    email 'jdoe@gmail.com'
    password 'password'
    password_confirmation 'password'
  end
end
