module MembershipRewardsHelper

  def format_participant_url(participant)
    return participant.url if participant.url.match(/http/)
    "http://#{participant.url}"
  end

  def region_display(participant)
    regions = participant.regions.map do |region|
      link_to region.name, membership_rewards_region_path(region)
    end
    regions.join(', ')
  end

end