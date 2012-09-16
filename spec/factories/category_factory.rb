FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "Category #{n}" }

    factory :category_with_participant do
      after(:build) do |category|
        category.participants << FactoryGirl.create(:participant)
      end
    end
  end
end