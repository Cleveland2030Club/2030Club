module UsersHelper
  def expiration_text(user)
    if user.expired_at
      " on #{user.expired_at.strftime('%B %d, %Y')}"
    else
      ''
    end
  end
end
