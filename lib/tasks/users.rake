namespace :users do

  desc "Downcase all user email addresses"
  task :downcase => :environment do
    User.all.each do |user|
      begin
        puts "Updating user email #{user.id}"
        user.email = user.email.downcase
        user.save
      rescue Exception => exception
        puts "Logging error for record #{user.id}"
        Rails.logger.info("#{excpetion}: on user record #{user.id}: #{user.first_name} #{user.last_name}")
      end
    end
  end

  desc "Find users that do not have a user_profile property"
  task :find_without_user_profile => :environment do
    users_without_profiles = []
    User.includes(:user_profile).find_each do |user|
      if user.user_profile.nil?
        users_without_profiles << user
      end
    end

    puts 'Users without associated user_profiles: '
    puts users_without_profiles.length
    puts users_without_profiles.map { |user| user.id }
  end

end
