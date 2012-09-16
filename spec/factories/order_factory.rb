FactoryGirl.define do
  factory :order do
    amount 70
    after(:build) do |order|
      order.customer = FactoryGirl.build(:user)
      order.items << FactoryGirl.build(:item)
    end
  end
end
