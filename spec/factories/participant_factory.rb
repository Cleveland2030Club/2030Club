FactoryGirl.define do
  factory :participant do
    benefit "benefit"
    bio "bio"
    instructions "instructions"
    sequence(:name) {|n| "Participant #{n}" }
  end
end