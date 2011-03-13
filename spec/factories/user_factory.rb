Factory.define(:user) do |f|
  f.first_name 'George'
  f.last_name 'Plate'
  f.url_friendly 'george_plate'
  f.email 'jdoe@gmail.com'
  f.password 'password'
  f.password_confirmation 'password'
end
