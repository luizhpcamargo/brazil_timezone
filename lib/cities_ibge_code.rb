ActiveSupport::TimeZone::MAPPING['Fernando de Noronha'] = 'America/Noronha'
ActiveSupport::TimeZone::MAPPING['Amazônia'] = 'America/Manaus'
ActiveSupport::TimeZone::MAPPING['Acre'] = 'America/Rio_Branco'
ActiveSupport::TimeZone.instance_variable_set('@zones', nil)
ActiveSupport::TimeZone.instance_variable_set('@zones_map', nil)

class CitiesIbgeCode

  def self.load_cities
    states =  Dir.glob(File.join(File.expand_path(File.dirname(__FILE__), "../lib/brazil_timezone/config/*")))
    cities = {}
    states.each do |file|
      city = YAML.load(File.read(file))
      cities.merge(city){|key, old_value, new_value| old_value.merge(new_value) }
    end
    cities
  end
end

