require "bridgetown"
require 'uri'
require 'net/http'
require 'openssl'
require 'dotenv/tasks'

Bridgetown.load_tasks

# Run rake without specifying any command to execute a deploy build by default.
task default: :deploy

#
# Standard set of tasks, which you can customize if you wish:
#
desc "Build the Bridgetown site for deployment"
task :deploy => [:clean, "frontend:build"] do
  Bridgetown::Commands::Build.start
end

desc "Build the site in a test environment"
task :test do
  ENV["BRIDGETOWN_ENV"] = "test"
  Bridgetown::Commands::Build.start
end

desc "Runs the clean command"
task :clean do
  Bridgetown::Commands::Clean.start
end

namespace :frontend do
  desc "Build the frontend with Webpack for deployment"
  task :build do
    sh "yarn run webpack-build"
  end

  desc "Watch the frontend with Webpack during development"
  task :dev do
    sh "yarn run webpack-dev --color"
  rescue Interrupt
  end
end

namespace :cache do
  desc "Purge Bunny.net CDN cache"
  task :purge => :dotenv do
    puts "Purging the CDN cache"

    if ENV['REVIEW'] != 'true'
      url = URI("https://api.bunny.net/pullzone/#{ENV['BUNNY_ZONE_ID']}/purgeCache")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["AccessKey"] = ENV['BUNNY_API_KEY']

      response = http.request(request)
      if response.code != "204"
        raise "Unexpected response from CDN. Expected 204, got #{response.code}\n Response body: #{response.body}"
      end
      puts "Cache purged"
    else
      puts "Skipping. In review app."
    end
  end
end

task "assets:precompile" do
  Rake::Task[:deploy].invoke
end

#
# Add your own Rake tasks here! You can use `environment` as a prerequisite
# in order to write automations or other commands requiring a loaded site.
#
# task :my_task => :environment do
#   puts site.root_dir
#   automation do
#     say_status :rake, "I'm a Rake tast =) #{site.config.url}"
#   end
# end
