require "simple/geocoder/version"
require "simple/geocoder/germany"
require "simple/geocoder/countries"

module Simple
  module Geocoder

    class Service
      attr_accessor :germany, :countries

      def initialize
        self.germany = Simple::Geocoder::Germany.new
        self.countries = Simple::Geocoder::Countries.new
      end

      def geocode postal_code, country_code = nil, city_name = nil
        postal_code = postal_code.to_s
        if country_code.present?
          country_code = country_code.upcase
          if country_code == 'DE'
            # search in German postal codes
            res = self.germany.geocode(postal_code)
          else
            # search in countries centroids
            res = self.countries.geocode(country_code)
          end
        else
          # try to search postal_code as a German one
          res = self.germany.geocode(postal_code)
        end
        # if nothing found, then it could be post box
        # try to search by city
        res = self.germany.geocode(city_name) if res.blank?

        # if still nothing found, use coordinates for Germany
        res = self.countries.geocode('DE') if res.blank?
        res
      end

    end


  end
end
