module Ask
  module Geocoder
    class Countries

      attr_accessor :dict

      def initialize
        path = File.expand_path('../../../geodata/country_centroids.csv', __FILE__)
        self.dict = {}
        File.readlines(path).each do |line|
          parts = line.strip.split(/\t+/)
          self.dict[parts.last.strip] = {lat: parts[0].strip.to_f, lon: parts[1].strip.to_f}
        end
      end

      def geocode country_code
        self.dict[country_code]
      end

    end
  end
end
