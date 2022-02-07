# This file is used by Rack-based servers during the Bridgetown boot process.

require "bridgetown-core/rack/boot"
require 'rack/rewrite'

use Rack::Rewrite do
  # Redirect from www to non-www
  r301 %r{.*}, 'https://johnathan.org$&', :if => Proc.new {|rack_env|
    rack_env['REQUEST_URI'] =~ /www.johnathan.org/
  }

  # Redirect http to https when in production and using the Heroku-hosted app
  if ENV['BRIDGETOWN_ENV'] == "production" && ENV['HOST_ENV'] == "heroku"
    r301 %r{.*}, 'https://jdotorg.herokuapp.com$&', :scheme => 'http'
  end

  # /2020/12/file-name.html => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*).html}, '/$1/'

  # /2020/12/file-name/ => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*)/}, '/$1/'

  # /2020/12/file-name => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*)}, '/$1/'
end

Bridgetown::Rack.boot

run RodaApp.freeze.app # see server/roda_app.rb