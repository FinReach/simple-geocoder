module Simple
  module Geocoder
    class Germany

      attr_accessor :dict

      def initialize
        path = File.expand_path('../../../geodata/de_postal_codes.csv', __FILE__)
        self.dict = {}
        File.readlines(path).each do |line|
          parts = line.strip.split(/\t+/)
          self.dict[parts[1].strip] = {lat: parts[-2].strip.to_f, lon: parts[-1].strip.to_f}
          self.dict[parts[2].strip] = {lat: parts[-2].strip.to_f, lon: parts[-1].strip.to_f}
        end
      end

      def geocode postal_code_or_city
        self.dict[postal_code_or_city]
      end

    end
  end
end
