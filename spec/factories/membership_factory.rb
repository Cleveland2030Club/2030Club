FactoryGirl.define do
  factory :membership do
    name 'Standard membership'
    after(:build) do |m|
      m.items = [FactoryGirl.build(:item, :product => m)]
    end
  end
end
