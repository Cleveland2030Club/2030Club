require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Cle2030
  class Application < Rails::Application
    config.autoload_paths += [config.root.join('lib')]
    config.encoding = 'utf-8'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  
    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
    # Specify gems that this application depends on and have them installed with rake gems:install
    # config.gem "bj"
    # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
    # config.gem "aws-s3", :lib => "aws/s3"
    # config.gem "sqlite3-ruby", :lib => "sqlite3"
    config.gem "authlogic", :version => '2.1.5'
    config.gem "paperclip", :version => '2.3.3'
    config.gem "activemerchant", :lib => "active_merchant", :version => "1.7.1"
    config.gem 'will_paginate', :version => '~> 2.3.11', :source => 'http://gemcutter.org'
    config.gem 'RedCloth'
  
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  
    #config.plugins = [:event_calendar]
  
    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'Eastern Time (US & Canada)'
  
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    # config.i18n.default_locale = :de
  
    # support yaml and heroku config vars, preferring ENV for heroku
    SETTINGS = (YAML.load_file('config/cleveland_2030_settings.yml')[RAILS_ENV] rescue {}).merge(ENV)
  
    # ActionMailer settings
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address => 'smtp.gmail.com',
      :port => 587,
      :authentication => :plain,
      :domain => 'cleveland2030.org',
      :user_name => SETTINGS['USER_NAME'],
      :password => SETTINGS['USER_PW']
    }
  end
end
