require 'active_support/concern'
require 'active_support/core_ext/array/extract_options'
require 'active_support/deprecation/reporting'

module BrazilTimezone
  module ActiveRecord
    module Zoneable
      extend ActiveSupport::Concern

      module ClassMethods
        def zone_in(field, *args)
          options = args.extract_options!
        end
      end
    end
  end
end
