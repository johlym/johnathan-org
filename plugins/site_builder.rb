class SiteBuilder < Bridgetown::Builder
  require 'dotenv/load'

  # write builders which subclass SiteBuilder in plugins/builders

  def log
    Bridgetown.logger
  end
end

