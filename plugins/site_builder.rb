class SiteBuilder < Bridgetown::Builder
  require 'dotenv/load'
  require 'active_support/all'

  # write builders which subclass SiteBuilder in plugins/builders

  def log
    Bridgetown.logger
  end

  def delimit(number)
    number.to_formatted_s(:delimited)
  end
end

