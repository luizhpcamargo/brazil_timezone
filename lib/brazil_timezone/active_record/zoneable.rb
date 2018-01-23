require 'active_support/concern'
require 'active_support/core_ext/array/extract_options'
require 'active_support/deprecation/reporting'
require_relative '../../cities_ibge_code.rb'

module BrazilTimezone
  module ActiveRecord
    module Zoneable
      extend ActiveSupport::Concern

      module ClassMethods
        def zone_in(field, *args)
          options = args.extract_options!

          define_method "now" do
            zone(public_send(field))
            Time.zone.now
          end

          define_method "zone" do |ibge|
            require 'pry'; binding.pry
            @cities ||= CitiesIbgeCode.load_cities
            return Time.zone = 'Fernando de Noronha' if noronha? ibge
            return Time.zone = 'Amazônia' if amazonia? ibge
            return Time.zone = 'Acre' if acre? ibge
            Time.zone = 'Brasilia'
          end

          ["brasilia", "noronha", "amazonia", "acre" ].each do |time|
            define_method "#{time}?" do |ibge|
              @cities[time].keys.include? ibge
            end
          end
        end
      end
    end
  end
end
