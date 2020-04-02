require_relative 'config'
require_relative 'helpers'

class DiscoverExoplanet < Sinatra::Base
  helpers Discover::Exoplanet::Helpers

  get "/" do
    init_data
    discover_exoplanet

    erb :main
  end

  not_found do
    'Oops. check your url!'
  end
end
