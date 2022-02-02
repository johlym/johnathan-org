# This file is used by Rack-based servers during the Bridgetown boot process.

require "bridgetown-core/rack/boot"
require 'rack/rewrite'

if ENV['BRIDGETOWN_ENV'] == "production" && ENV['HOST_ENV'] == "heroku"
  use Rack::Rewrite do
    r301 %r{.*}, 'https://jdotorg.herokuapp.com$&', :scheme => 'http'
  end
end

Bridgetown::Rack.boot

run RodaApp.freeze.app # see server/roda_app.rb
