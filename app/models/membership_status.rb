class MembershipStatus

  attr_read :user, :status

  def initialize(user)
    @user = user
  end

  def set_status
    case 
    when user.expired_at.nil?
      update_expired_at
      set_status
    when (user.expired_at - 1.month) > Time.now
      status = :current
    when user.expired_at > Time.now
      status = :current_with_less_than_30_days
    when (user.expired_at + 1.month) > Time.now
      status = :expired_with_less_than_30_days
    else
      status = :expired
    end
  end

  def update_expired_at
    if user.joined_at
      user.expired_at = user.joined_at.end_of_month + 1.year
    else
      user.expired_at = user.created_at.end_of_month + 1.year
    end
  end

end