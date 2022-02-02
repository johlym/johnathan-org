class Builders::Raindrop < SiteBuilder
  RAINDROP_API_ROOT = "https://api.raindrop.io/rest/v1"
  HEADERS = {"Authorization" => "Bearer #{ENV['RAINDROP_KEY']}"}

  def build
    unless ENV['RAINDROP_KEY']
      Bridgetown.logger.warn "No RAINDROP_KEY set. Skipping."
      return
    end
    hook :site, :post_read do
      Bridgetown.logger.info "Starting Raindrip Collector"
      link_structure = {
        categories: [],
        total: 0
      }
      count = 0

      if Bridgetown.environment == "development"
        Bridgetown.logger.info "Development environment detected, faking it."
        site.data[:links] = {
          categories: [
            {
              name: "Test category",
              id: 123456789,
              links: [
                {
                  title: "Test link",
                  from: "example.com",
                  url: "https://example.com",
                  tags: [
                    "tag1",
                    "tag2"
                  ]
                }
              ]
            }
          ],
          total: 999
        }
      else
        Bridgetown.logger.info "Querying Raindrop.io for collections"
        begin
          collections = collect_collections
          collections.each do |collection|
            Bridgetown.logger.info "Querying Raindrop.io for collection ID #{collection._id}: #{collection.title}"
            links = collect_links(collection._id)
            link_output = []
            links.each do |link|
              link_output << {
                title: link.title,
                from: link.domain,
                url: link.link,
                tags: link.tags
              }
              count += 1
            end
            link_structure[:categories] << {
              name: collection.title,
              id: collection._id,
              links: link_output
            }
            link_structure[:total] = count
          end
          site.data[:links] = link_structure
          Bridgetown.logger.info "Raindrop Collector finished"
        rescue => exception
          Bridgetown.logger.warn "There was a problem connecting to Raindrop or building the list. Error: #{exception}"
        end
      end
    end
  end

  def collect_collections
    rd_collection_request = Faraday.get("#{RAINDROP_API_ROOT}/collections", {}, HEADERS)
    JSON.parse(rd_collection_request.body, object_class: OpenStruct).items
  end

  def collect_links(collection_id)
    request = Faraday.get("#{RAINDROP_API_ROOT}/raindrops/#{collection_id}", {}, HEADERS)
    JSON.parse(request.body, object_class: OpenStruct).items
  end
end