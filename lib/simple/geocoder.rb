require "simple/geocoder/version"
require "simple/geocoder/germany"
require "simple/geocoder/countries"

module Simple
  module Geocoder

    class Service
      attr_accessor :germany, :countries, :austria

      def initialize
        self.germany = Simple::Geocoder::Germany.new
        self.austria = Simple::Geocoder::Austria.new
        self.countries = Simple::Geocoder::Countries.new
      end

      def geocode postal_code, country_code = nil, city_name = nil
        postal_code = postal_code.to_s
        if country_code.present?
          country_code = country_code.upcase
          case country_code
            when 'DE'
              res = self.germany.geocode(postal_code)
              # if nothing found, then it could be post box
              # try to search by city
              res = self.germany.geocode(city_name) if res.blank?
            when 'AT'
              res = self.austria.geocode(postal_code)
              res = self.austria.geocode(city_name) if res.blank?
            else
              # search in countries centroids
              res = self.countries.geocode(country_code)
          end
        else
          # try to search postal_code as a German one
          res = self.germany.geocode(postal_code)
        end

        # if still nothing found, use coordinates for Germany
        res = self.countries.geocode('DE') if res.blank?
        res
      end

    end


  end
end
