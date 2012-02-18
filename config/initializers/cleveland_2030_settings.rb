require 'yaml'

module Cleveland2030Settings
  def self.config
    if not defined? @config
      @config = (YAML.load_file("#{RAILS_ROOT}/config/cleveland_2030_settings.yml")[RAILS_ENV] rescue {}).merge(ENV)
    end
    @config
  end
end