Factory.define :membership_reward, :class => Participant do |f|
  f.sequence(:name) { |i| "Participant #{i}" }
  f.bio 'bio for particpant'
  f.benefit 'free beer'
  f.instructions 'sing a song to the doorman'
end
