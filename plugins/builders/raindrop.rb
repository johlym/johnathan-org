class Builders::Raindrop < SiteBuilder
  RAINDROP_API_ROOT = "https://api.raindrop.io/rest/v1".freeze
  
  def build
    get "#{RAINDROP_API_ROOT}/collections", headers: {"Authorization" => "Bearer 6bd36be9-c55e-4cb9-ba0e-a4b9699fb8af"} do |data|
      p data
    end
  end
end