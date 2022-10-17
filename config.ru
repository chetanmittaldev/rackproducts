require './application'

use Rack::Reloader, 0 # this middleware basically reloads changes when actively called aka page refresh
run Application.new # creates a new application object and runs call method required by rackup (rack)
