# This file is used by Rack-based servers during the Bridgetown boot process.

require "bridgetown-core/rack/boot"
require 'rack/rewrite'

use Rack::Rewrite do
  r301 %r{.*}, 'https://jdotorg.herokuapp.com$&', :scheme => 'http'
end

Bridgetown::Rack.boot

run RodaApp.freeze.app # see server/roda_app.rb
