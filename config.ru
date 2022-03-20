# This file is used by Rack-based servers during the Bridgetown boot process.

require "bridgetown-core/rack/boot"
require 'rack/rewrite'

use Rack::Rewrite do
  

  
  # if ENV['BRIDGETOWN_ENV'] == "production" && ENV['HOST_ENV'] == "heroku"
  #   # Redirect from www to non-www
  #   r301 %r{.*}, 'https://johnathan.org$&', :if => Proc.new {|rack_env|
  #     rack_env['SERVER_NAME'] != 'johnathan.org'
  #   }

  #   # Redirect http to https when in production and using the Heroku-hosted app
  #   r301 %r{.*}, 'https://jdotorg.herokuapp.com$&', :scheme => 'http'
  # end

  # /2020/12/file-name.html => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*).html}, '/$1/'

  # /2020/12/file-name/ => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*)/}, '/$1/'

  # /2020/12/file-name => /file-name/
  r301 %r{/\d{4}/\d{2}/(.*)}, '/$1/'

  ## Custom redirects to clean up references in old locations on the Internet
  r301 %r{/contact[/]?}, '/about/'
  r301 %r{/colophon[/]?}, '/about/'
  r301 %r{/stream-rtmp[/]?}, '/attempting-to-stream-a-webcam-to-an-rtmp-server/'
  r301 %r{/rtmp-nginx-apt[/]?}, '/add-rtmp-support-to-nginx-installed-from-apt/'
  r301 %r{/site-archives.*}, '/'
  r301 %r{/tag.*}, '/'
  r301 %r{/author.*}, '/about/'
  r301 %r{/rss.*}, '/feed.xml'
  r301 %r{/feed?cat=-434}, '/feed.xml'
end

Bridgetown::Rack.boot

run RodaApp.freeze.app # see server/roda_app.rb