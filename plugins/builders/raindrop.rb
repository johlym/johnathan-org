class Builders::Raindrop < SiteBuilder
  RAINDROP_API_ROOT = "https://api.raindrop.io/rest/v1"
  HEADERS = {"Authorization" => "Bearer 6bd36be9-c55e-4cb9-ba0e-a4b9699fb8af"}

  def build
    hook :site, :post_read do
      Bridgetown.logger.info "Starting Raindrip Collector"
      link_structure = {
        categories: [],
        total: 0
      }
      count = 0

      Bridgetown.logger.info "Querying Raindrop.io for collections"
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