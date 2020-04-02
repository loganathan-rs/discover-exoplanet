module Discover
  module Exoplanet
    module Helpers

      def init_data
        get_exoplanet_data
        get_no_of_orphan_planets
        get_planet_orbiting_hottest_star
      end

      def discover_exoplanet
        @data = PLANET_GROUPS.map{ |group| Hash["name", group, "data", eval("#{group.downcase}_planets_data") ]}
      end

      def get_no_of_orphan_planets
        @no_of_orphan_planets = @raw_data.select{ |planet| planet[TYPE_FLAG_FIELD].to_i == ORPHAN_PLANET_FLAG }.count
      end

      def get_planet_orbiting_hottest_star
        @planet_orbiting_hottest_star = @raw_data.max_by{ |planet| planet[HOST_STAR_TEMP_FIELD].to_i }[PLANET_IDENTIFIER_FIELD]
      end

      def small_planets
        @raw_data.select{ |planet| planet[PLANET_RADIUS_FIELD].to_i < SMALL_PLANET_MAX_SIZE }
      end

      def medium_planets
        @raw_data.select{ |planet| planet[PLANET_RADIUS_FIELD].to_i >= SMALL_PLANET_MAX_SIZE && planet[PLANET_RADIUS_FIELD].to_i < MEDIUM_PLANET_MAX_SIZE }
      end

      def large_planets
        @raw_data.select{ |planet| planet[PLANET_RADIUS_FIELD].to_i >= MEDIUM_PLANET_MAX_SIZE }
      end

      def small_planets_data
        small_planets.map{ |planet| planet[DISCOVERY_YEAR_FIELD] }.tally
      end

      def medium_planets_data
        medium_planets.map{ |planet| planet[DISCOVERY_YEAR_FIELD] }.tally
      end

      def large_planets_data
        large_planets.map { |planet| planet[DISCOVERY_YEAR_FIELD] }.tally
      end

      def get_exoplanet_data
        unless File.exists?(LOCAL_SOURCE_JSON_FILE)
          download_source
        end
        source_file = File.read(LOCAL_SOURCE_JSON_FILE)
        @raw_data = JSON.parse(source_file)
      end

      def download_source
        uri = URI(SOURCE_URL)
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Get.new uri

          http.request request do |response|
            open LOCAL_SOURCE_JSON_FILE, 'w' do |io|
              response.read_body do |chunk|
                io.write chunk
              end
            end
          end
        end
      end

    end
  end
end
