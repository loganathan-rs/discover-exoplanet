require 'sinatra/base'
require 'chartkick'
require 'net/http'

PLANET_GROUPS = ["Small", "Medium", "Large"]

ORPHAN_PLANET_FLAG      = 3
SMALL_PLANET_MAX_SIZE   = 1
MEDIUM_PLANET_MAX_SIZE  = 2

PLANET_RADIUS_FIELD     = "RadiusJpt"
DISCOVERY_YEAR_FIELD    = "DiscoveryYear"
TYPE_FLAG_FIELD         = "TypeFlag"
HOST_STAR_TEMP_FIELD    = "HostStarTempK"
PLANET_IDENTIFIER_FIELD = "PlanetIdentifier"

SOURCE_URL = 'https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets'
LOCAL_SOURCE_JSON_FILE = './public/planets.json'
