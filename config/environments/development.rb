# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  if Cleveland2030Settings.config['DEV_PAYMENT_LOGIN'] and
    Cleveland2030Settings.config['DEV_PAYMENT_PASSWORD'] and
    Cleveland2030Settings.config['DEV_PAYMENT_SIGNATURE']
    ::GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
      :login => Cleveland2030Settings.config['DEV_PAYMENT_LOGIN'],
      :password => Cleveland2030Settings.config['DEV_PAYMENT_PASSWORD'],
      :signature => Cleveland2030Settings.config['DEV_PAYMENT_SIGNATURE']
    )
  else
    Rails.logger.warn('Paypal environment variables are not set!')
  end
end

config.gem 'cucumber-rails',   :lib => false, :version => '0.3.2' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber-rails'))
config.gem 'database_cleaner', :lib => false, :version => '0.5.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/database_cleaner'))
config.gem 'capybara',         :lib => false, :version => '0.3.5' unless File.directory?(File.join(Rails.root, 'vendor/plugins/capybara'))
config.gem 'rspec',            :lib => false, :version => '1.3.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec'))
config.gem 'rspec-rails',      :lib => false, :version => '1.3.2' unless File.directory?(File.join(Rails.root, 'vendor/plugins/rspec-rails'))
config.gem 'fastercsv'
config.gem "factory_girl", :lib => "factory_girl", :source => "http://gems.github.com" unless File.directory?(File.join(Rails.root, "vendor/plugins/factory_girl"))
config.gem "thoughtbot-shoulda", :lib => false, :source => "http://gems.github.com" unless File.directory?(File.join(Rails.root, "vendor/plugins/thoughtbot-shoulda"))
