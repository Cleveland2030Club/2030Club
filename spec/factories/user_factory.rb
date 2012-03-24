Factory.define(:user) do |f|
  f.first_name 'George'
  f.last_name 'Plate'
  f.url_friendly 'george_plate'
  f.email 'jdoe@gmail.com'
  f.password 'password'
  f.password_confirmation 'password'
end

Factory.define(:active_user, :parent=>:user) do |f|
  f.expired_at Date.today + 1.year
end
