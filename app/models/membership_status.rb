class MembershipStatus

  attr_reader :user

  def initialize(user)
    @user = user
    #TODO Refactor later back into model
    if @user.expired_at.nil?
      update_user_expired_at
    end
  end

  def status
    case 
    when !user.activated?
      :not_active
    when (user.expired_at - 30.days) > Time.now
      :current
    when user.expired_at > Time.now
      :current_with_less_than_30_days
    when (user.expired_at + 30.days) > Time.now
      :expired_with_less_than_30_days
    else
      :expired
    end
  end

  private

  def update_user_expired_at
    return unless user.activated?

    if user.joined_at
      user.expired_at = user.joined_at.end_of_month + 1.year
    else
      user.expired_at = user.created_at.end_of_month + 1.year
    end
    user.save
  end

end
