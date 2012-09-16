FactoryGirl.define do
  factory :user_address do
    user_id 1
    address '111 Cleveland Avenue'
    city 'Cleveland'
    state_code 'OH'
    zip '46751'
    address_type_id 1
    is_primary true
    sort_order 1
  end
end
