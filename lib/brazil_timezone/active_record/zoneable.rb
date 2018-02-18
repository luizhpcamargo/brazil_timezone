require 'active_support/concern'
require 'active_support/core_ext/array/extract_options'
require 'active_support/deprecation/reporting'
require_relative '../../cities_ibge_code.rb'

module BrazilTimezone
  module ActiveRecord
    module Zoneable
      extend ActiveSupport::Concern

      attr_accessor :brazil_city_ibge_code

      module ClassMethods
        def zone_in(field, *args)
          options = args.extract_options!

          alias_attribute :brazil_city_ibge_code, field

          set_callback :initialize, :after, :change_time_zone unless options[:auto_load] == false

        end
      end

      def event_time_formatted
        change_time_zone
        Time.zone.now.iso8601
      end

      def change_time_zone
        @cities ||= CitiesIbgeCode.load_cities
        Time.zone = zone_name.is_a?(String) ? "America/#{zone_name}" : 'Brasilia'
      end

      def find_zone_name
        return 'Sao_Paulo' if brazil_city_ibge_code.blank?
        %w(Noronha
        Belem
        Fortaleza
        Recife
        Araguaina
        Maceio
        Bahia
        Sao_Paulo
        Campo_Grande
        Cuiaba
        Porto_Velho
        Boa_Vista
        Manaus
        Rio_Branco).each do |zone|
          return zone if @cities[zone].keys.include? brazil_city_ibge_code
        end
      end

      def zone_name
        @zone_name ||= find_zone_name
      end

    end
  end
end