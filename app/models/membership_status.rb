class MembershipStatus

  attr_reader :user, :status

  def initialize(user)
    @user = user
    #TODO Refactor later back into model
    if user.expired_at.nil?
      update_expired_at(user)
    end
  end

  def status
    case 
    when (user.expired_at - 30.days) > Time.now
      @status = :current
    when user.expired_at > Time.now
      @ststus = :current_with_less_than_30_days
    when (user.expired_at + 30.days) > Time.now
      @status = :expired_with_less_than_30_days
    else
      @status = :expired
    end
  end

  private

  def update_expired_at(user)
    if user.joined_at
      user.expired_at = user.joined_at.end_of_month + 1.year
    else
      user.expired_at = user.created_at.end_of_month + 1.year
    end
  end

end
