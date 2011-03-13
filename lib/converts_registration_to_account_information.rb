class ConvertsRegistrationToAccountInformation

  def do_it registration
    ActiveRecord::Base.transaction do
      user = converts_registration_to_user(registration)

      handles_user_to_user_profile_configuration(registration, user)
      handles_user_to_user_address_configuration(registration, user)

      user.save! #single write to db
      user
    end
  end

private

  def handles_user_to_user_profile_configuration(registration, user)
    user_profile = UserProfile.new
    user_profile.phone_number = registration.phone_number
    user_profile.profession = registration.profession
    user_profile.employer = registration.employer
    user_profile.education = registration.education
    user_profile.about2030 = registration.about2030
    user_profile.user = user
    user_profile.save!
    user_profile
  end

  def handles_user_to_user_address_configuration(registration, user)
    user_address = UserAddress.new
    user_address.user = user
    user_address.address_type_id = 1
    user_address.address = registration.address
    user_address.address2 = registration.address2
    user_address.city = registration.city
    user_address.state_code = registration.state
    user_address.zip = registration.zip
    user_address.is_primary = true
    user_address.save!
    user_address
  end

  def converts_registration_to_user(registration)
    user = User.new
    user.first_name = registration.first_name
    user.last_name = registration.last_name
    user.email = registration.email
    user.password = registration.password
    user.password_confirmation = registration.password_confirmation
    user.active = true
    user.save!
    user
  end

end
