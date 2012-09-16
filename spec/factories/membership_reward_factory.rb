FactoryGirl.define do
  factory :membership_reward, :class => Participant do
    sequence(:name) { |i| "Participant #{i}" }
    bio 'bio for particpant'
    benefit 'free beer'
    instructions 'sing a song to the doorman'
  end
end
