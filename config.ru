require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require File.expand_path('app', File.dirname(__FILE__))

run DiscoverExoplanet
