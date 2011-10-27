module MembershipRewardsHelper

  def format_participant_url(participant)
    return participant.url if participant.url.match(/http/)
    "http://#{participant.url}"
  end

end