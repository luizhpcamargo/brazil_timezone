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

          zone field

          define_method "now" do |*args|
            Time.zone.now
          end
        end

        def zone(field)
          @cities ||= CitiesIbgeCode.load_cities
          Time.zone = 'Fernando de Noronha' if noronha? field
          Time.zone = 'Amazônia' if amazonia? field
          Time.zone = 'Acre' if acre? field
          Time.zone = 'Brasilia'
        end

        ["brasilia", "noronha", "amazonia", "acre" ].each do |time|
          define_method "#{time}?" do |field|
            @cities[time].keys.include? field
          end
        end
      end
    end
  end
end
