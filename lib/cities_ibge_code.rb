ActiveSupport::TimeZone::MAPPING['Fernando de Noronha'] = 'America/Noronha'
ActiveSupport::TimeZone::MAPPING['Amazônia'] = 'America/Manaus'
ActiveSupport::TimeZone::MAPPING['Acre'] = 'America/Rio_Branco'
ActiveSupport::TimeZone.instance_variable_set('@zones', nil)
ActiveSupport::TimeZone.instance_variable_set('@zones_map', nil)

class CitiesIbgeCode
  attr_accessor :cities

  def load_cities
    states =  Dir.glob("../lib/brazil_timezone/config/*")
    self.cities = {}
    states.each do |file|
      city = YAML.load(File.read(file))
      self.cities.merge(city){|key, old_value, new_value| old_value.merge(new_value) }
    end
  end

  def time_zones
    load_cities
  end
end

