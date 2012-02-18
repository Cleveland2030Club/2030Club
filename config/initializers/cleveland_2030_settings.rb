require 'yaml'

module Cleveland2030Settings
  def self.config
    if not defined? @config
      @config = YAML::load(File.open("#{RAILS_ROOT}/config/cleveland_2030_settings.yml"))
      @config = @config[ENV['RAILS_ENV']]
    end
    @config
  end
end