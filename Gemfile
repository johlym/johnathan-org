ruby File.read(".ruby-version").strip

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "barnes", "~> 0.0.9"
gem "bridgetown", "~> 1.3"
gem "bridgetown-cloudinary", "~> 2.1"
gem "bridgetown-feed", "~> 3.0.0"
gem "bridgetown-seo-tag", "~> 6.0"
gem "dotenv", "~> 2.8.1"
gem "puma", "~> 6.3"
gem "rack-rewrite", "~> 1.5.1"
gem "reverse_markdown", "~> 2.1.1"

group :test, optional: true do
  gem "minitest"
  gem "minitest-profile"
  gem "minitest-reporters"
  gem "nokogiri"
  gem "rails-dom-testing"
  gem "shoulda"
end
