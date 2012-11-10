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

end