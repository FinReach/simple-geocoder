require "simple/geocoder/version"
require "simple/geocoder/postal_codes"
require "simple/geocoder/countries"

module Simple
  module Geocoder

    class Service
      attr_accessor :postal_codes, :countries

      def initialize
        self.postal_codes = Simple::Geocoder::PostalCodes.new
        self.countries = Simple::Geocoder::Countries.new
      end

      def geocode postal_code, country_code = nil
        if country_code.present?
          country_code = country_code.upcase
          if country_code == 'DE'
            # search in German postal codes
            res = self.postal_codes.geocode(postal_code)
          else
            # search in countries centroids
            res = self.countries.geocode(country_code)
          end
        else
          # try to search postal_code as a German one
          res = self.postal_codes.geocode(postal_code)
        end
        # if nothing found, use coordinates for Germany
        res = self.countries.geocode('DE') if res.blank?
        res
      end

    end


  end
end