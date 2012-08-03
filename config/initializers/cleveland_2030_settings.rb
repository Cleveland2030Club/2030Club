require 'yaml'

module Cleveland2030Settings
  def self.config
    if not defined? @config
      @config = (YAML.load_file("#{Rails.root}/config/cleveland_2030_settings.yml")[Rails.env] rescue {}).merge(ENV)
    end
    @config
  end
end