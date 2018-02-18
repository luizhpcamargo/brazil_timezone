class CitiesIbgeCode

  def self.create_hash
    states =  Dir.glob(File.join(File.dirname(__FILE__), "states/*"))
    @cities = {}
    states.each do |file|
      city = YAML.load(File.read(file))
      @cities.merge!(city){|key, old_value, new_value| old_value.merge(new_value) }
    end
    @cities.freeze
  end

  def self.load_cities
    @cities || create_hash
  end
end

